//
//  HistoryCourseViewController.swift
//  WangXiao
//
//  Created by penguin on 2021/6/4.
//

import UIKit


/// 历史课程
class HistoryCourseViewController: BaseViewController {
    
    var userId:Int = 0
    
    var userRole:String = ""
    
    var datalist:[HistoryCourseModel] = []
    
    //MARK: 列表
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = color_gray2
        tableView.separatorStyle = .none
        tableView.register(HistoryCourseCell.self, forCellReuseIdentifier: "HistoryCourseCell")
        /// 控制顶部留白
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle(text: "历史课程")
        createUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(isTranslucent: false,
                         isHiddenNavigationBar: false,
                         animated: true)
    }
    
    func loadData() {
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String:String] = [:]
        parameters["userId"] = String(userId)
        parameters["userRole"] = userRole
        print(parameters)
        manager.GETRequest(URLString: INTERFACE_getCourseVideoList,
                           parameters: &parameters,
                           token: APPSingleton.shared.QMToken,
                           success: {requestData in
                            AppPrint(JSONSerialization.JSONString(object: requestData))
                            let code: Int? = requestData["code"] as? Int
                            if StatusCode.succeed(code: code){
                                //
                                if let data:[[String:Any]] = requestData["data"] as? [[String:Any]]{
                                    for obj in data {
                                        let avatarUrl = obj["avatarUrl"] as? String ?? ""
                                        let courseName = obj["courseName"] as? String ?? ""
                                        let startTime = obj["startTime"] as? String ?? ""
                                        let endTime = obj["endTime"] as? String ?? ""
                                        let fileId = obj["fileId"] as? String ?? ""
                                        let nickName = obj["nickName"] as? String ?? ""
                                        var tempVideoUrl:[VideoModel] = []
                                        if let videoUrls = obj["videoInfos"] as? [[String:Any]] {
                                            var i = 1
                                            for videoUrl in videoUrls {
                                                let title = "第\(i)段"
                                                i = i + 1
                                                let url:String = videoUrl["videoUrl"] as? String ?? ""
                                                tempVideoUrl.append(VideoModel(title: title, videoUrl: url))
                                            }
                                        }
                                        let model = HistoryCourseModel(avatarUrl: avatarUrl,
                                                                       courseName: courseName,
                                                                       startTime: startTime,
                                                                       endTime: endTime,
                                                                       fileId: fileId,
                                                                       nickName: nickName,
                                                                       videoUrl: tempVideoUrl)
                                        self.datalist.append(model)
                                    }
                                    self.tableView.reloadData()
                                }
                                else {
                                    
                                }
                            }
                            else{
                            }
                           },
                           failure: { error in
                            
                           })
        
    }

    func createUI() {
        view.backgroundColor = color_gray2
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - UITableViewDelegate
extension HistoryCourseViewController:UITableViewDelegate {
    
    /// 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.datalist[indexPath.row]
        if model.videoUrl.count>0 {
            let VC = CourseDetailViewController()
            VC.info = model
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension HistoryCourseViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCourseCell", for: indexPath) as! HistoryCourseCell
        let model = self.datalist[indexPath.row]
        cell.model = model
        return cell
    }
}
