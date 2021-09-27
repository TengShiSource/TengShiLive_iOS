//
//  CourseDetailViewController.swift
//  WangXiao
//
//  Created by penguin on 2021/6/8.
//

import UIKit
import AVKit

/// 课程详情
class CourseDetailViewController: BaseViewController {
    
    var info:HistoryCourseModel? {
        didSet {
            
        }
    }

    lazy var playerViewController: AVPlayerViewController = {
        let vc = AVPlayerViewController()
        return vc
    }()
    
    // 课程名称
    lazy var courseNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = info?.courseName
        return label
    }()
    
    // 头像
    lazy var pictureView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // 授课人
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = info?.nickName
        return label
    }()
    
    var datalist:[VideoNumberModel] = []
    /// collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        /// 控制顶部留白
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(VideoNumberCell.self, forCellWithReuseIdentifier: "VideoNumberCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle(text: "课程详情")
        
        if let videoUrls:[VideoModel] = self.info?.videoUrl {
            for model in videoUrls {
                print(model.videoUrl)
                datalist.append(VideoNumberModel(title: model.title,
                                                 isSelected: false,
                                                 videoUrl: model.videoUrl))
            }
        }
        
        // 默认播放第一个
        let model = datalist.first
        model?.isSelected = true
        if let url = URL(string: model?.videoUrl ?? "") {
            //控制器推出的模式
            let player = AVPlayer(url: url)
            playerViewController.player = player
        }
        
        view.addSubview(playerViewController.view)
        playerViewController.view.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(UIScreen.main.bounds.width/16*9)
        }
        playerViewController.player?.play()
        //课堂名称
        view.addSubview(courseNameLabel)
        courseNameLabel.snp.makeConstraints { make in
            make.top.equalTo(UIScreen.main.bounds.width/16*9)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }

        if let sInfo:HistoryCourseModel = info {
            pictureView.sd_setImage(with: URL(string: sInfo.avatarUrl),
                                        placeholderImage: UIImage(named: "Default_UserAvatar"))
        }
        view.addSubview(pictureView)
        pictureView.layer.cornerRadius = 17.5
        pictureView.layer.masksToBounds = true
        pictureView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 35, height: 35))
            make.top.equalTo(courseNameLabel.snp.bottom).offset(10)
            make.left.equalTo(courseNameLabel)
        }
        let label = UILabel()
        label.text = "授课"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(pictureView)
            make.width.equalTo(view).multipliedBy(0.5)
            make.height.equalTo(pictureView).multipliedBy(0.5)
            make.left.equalTo(pictureView.snp.right).offset(10)
        }
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pictureView)
            make.size.equalTo(label)
            make.left.equalTo(label)
        }
        
        let separateView = UIView()
        separateView.backgroundColor = color_gray2
        view.addSubview(separateView)
        separateView.snp.makeConstraints { make in
            make.top.equalTo(pictureView.snp.bottom).offset(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(20)
        }

        let sectionLabel = UILabel()
        sectionLabel.text = "课程列表"
        sectionLabel.font = UIFont.systemFont(ofSize: 18)
        sectionLabel.textAlignment = .left
        view.addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(separateView.snp.bottom).offset(20)
            make.left.equalTo(15)
            make.right.equalTo(0)
            make.height.equalTo(35)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
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

extension CourseDetailViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = datalist[indexPath.row]
        
        if model.isSelected == false {
            for i in 0..<datalist.count {
                let data = datalist[i]
                if i == indexPath.row {
                    data.isSelected = true
                }
                else {
                    data.isSelected = false
                }
            }
            self.collectionView.reloadData()
            
            if let url = URL(string: model.videoUrl) {
                //控制器推出的模式
                let player = AVPlayer(url: url)
                playerViewController.player = player
                playerViewController.player?.play()
            }
        }
    }
}

extension CourseDetailViewController:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datalist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.datalist[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoNumberCell", for: indexPath) as! VideoNumberCell
        cell.model = model
        return cell
    }
}

extension CourseDetailViewController:UICollectionViewDelegateFlowLayout {
    
    /// 设置cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.width/4.0
        return CGSize(width: w, height: 45)
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
