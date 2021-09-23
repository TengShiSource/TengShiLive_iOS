//
//  AvatarListViewController.swift
//  WangXiao
//
//  Created by penguin on 2021/6/4.
//

import UIKit

@objc protocol AvatarListViewControllerDelegate : NSObjectProtocol {
    ///
    @objc func avatarListDidSelected(imageURL:String)
    
}

/// 头像选取
class AvatarListViewController: BaseViewController {
    
    weak var delegate:AvatarListViewControllerDelegate?
    
    var datalist:[String] = []
    /// collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = color_gray2
        /// 控制顶部留白
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(AvatarListCell.self, forCellWithReuseIdentifier: "AvatarListCell")
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle(text: "选择头像")
        // Do any additional setup after loading the view.
        
        createUI()
        requestData()
        
    }
    
    func createUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }

    func requestData() {
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String:String] = [:]
        manager.GETRequest(URLString: INTERFACE_getAvatarUrlList,
                           parameters: &parameters,
                           token: APPSingleton.shared.QMToken,
                           success: {requestData in
                            print(JSONSerialization.JSONString(object: requestData))
                            let code: Int? = requestData["code"] as? Int
                            if StatusCode.succeed(code: code){
                                //
                                if let data:[String] = requestData["data"] as? [String]{
                                    self.datalist = data
                                    self.collectionView.reloadData()
                                }
                                else {
                                    HUDManager.showHUDWithError(content: "空数据")
                                }
                            }
                            else{
                                HUDManager.showHUDWithError(content: requestData["msg"] as? String ?? "code:\(String(describing: code))")
                            }
                           },
                           failure: { error in
                            HUDManager.showHUDWithError(content: error.debugDescription)
                           })
    }

}


extension AvatarListViewController:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.avatarListDidSelected(imageURL: datalist[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }

}

extension AvatarListViewController:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datalist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageURL = self.datalist[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarListCell", for: indexPath) as! AvatarListCell
        cell.imageUrl = imageURL
        return cell
    }
}

extension AvatarListViewController:UICollectionViewDelegateFlowLayout {
    
    /// 设置cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.width/4.0
        return CGSize(width: w, height: w)
    }
    
    /// 行与行之间的间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 0
    }
    /// item之间的间隔(默认是10)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
}
