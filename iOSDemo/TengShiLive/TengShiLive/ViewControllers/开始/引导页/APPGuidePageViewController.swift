//
//  APPGuidePageViewController.swift
//  WangXiao
//
//  Created by penguin on 2020/12/22.
//

import UIKit

/// 引导页Cell
class APPGuidePageCell: UICollectionViewCell {
    static let identifier = "APPGuidePageCell"
    var indexPath = IndexPath()
    
    lazy var bottomView: UIImageView = {
        let bottomView = UIImageView()
        bottomView.contentMode = .scaleToFill
        return bottomView
    }()
    
    lazy var foregroundView: UIImageView = {
        let foregroundView = UIImageView()
        foregroundView.contentMode = .scaleAspectFit
        foregroundView.backgroundColor = UIColor.color(red: 0, green: 0, blue: 0, alpha: 0)
        return foregroundView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        self.contentView.addSubview(foregroundView)
        let space:CGFloat = UIScreen.main.bounds.width * 0.12
        foregroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: space, bottom: 0, right: space))
        }
    }
    
    ///数据模型
    var model:GuideImage? {
        didSet {
            if let cellModel = model {
                bottomView.image = UIImage(named: cellModel.backgroundImage)
                foregroundView.image = UIImage(named: cellModel.foregroundImage)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
struct GuideImage {
    /// 背景图
    var backgroundImage:String
    /// 前景图
    var foregroundImage:String
}
/// 引导页
class APPGuidePageViewController: BaseViewController {
    
    /// 图片地址列表
    let image1 = GuideImage(backgroundImage: "引导页背景1", foregroundImage: "引导页前景1")
    private lazy var imageList:[GuideImage] = [image1]
    
    /// collectionView布局
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        /// 设置滚动方向
        flowLayout.scrollDirection = .horizontal
        /// 设置cell的大小
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        /// 缩进（上,左,下,右）
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        /// 行与行之间的间隔
        flowLayout.minimumLineSpacing = 0.0
        /// item之间的间隔(默认是10)
        flowLayout.minimumInteritemSpacing = 0.0
        return flowLayout
    }()
    /// collectionView
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        /// 控制顶部留白
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(APPGuidePageCell.self, forCellWithReuseIdentifier: APPGuidePageCell.identifier)
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        // 底部分页控制
        pageControl.numberOfPages = imageList.count
        pageControl.currentPage = 0
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(20)
            make.bottom.equalTo(-30)
        }
    }

}

extension APPGuidePageViewController:UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x:Int = Int(scrollView.contentOffset.x/self.collectionView.frame.width)
        self.pageControl.currentPage = x
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == imageList.count - 1 {
            // 进入下一页
            APPNavigationManager.replaceToHomePage()
        }
    }
}

extension APPGuidePageViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APPGuidePageCell.identifier, for: indexPath) as! APPGuidePageCell
        cell.model = imageList[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
}
