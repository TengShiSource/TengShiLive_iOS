//
//  AvatarListCell.swift
//  WangXiao
//
//  Created by penguin on 2021/6/23.
//

import UIKit

class AvatarListCell: UICollectionViewCell {
    
    var imageUrl:String? {
        didSet {
            if let url = imageUrl {
                pictureView.sd_setImage(with: URL(string: url),
                                            placeholderImage: UIImage(named: "Default_UserAvatar"))
            }
        }
    }
    
    /// 图片
    lazy var pictureView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(pictureView)
        pictureView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
