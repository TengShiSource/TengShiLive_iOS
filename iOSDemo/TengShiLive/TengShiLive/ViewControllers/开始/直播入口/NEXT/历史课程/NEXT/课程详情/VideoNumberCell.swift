//
//  VideoNumberCell.swift
//  WangXiao
//
//  Created by penguin on 2021/6/8.
//

import UIKit

class VideoNumberModel {
    var title:String = ""
    var isSelected:Bool = false
    var videoUrl:String = ""
    init(title:String,
         isSelected:Bool,
         videoUrl:String) {
        self.title = title
        self.isSelected = isSelected
        self.videoUrl = videoUrl
    }
}

class VideoNumberCell: UICollectionViewCell {
    
    var model:VideoNumberModel? {
        didSet {
            if let cellModel = model {
                label.text = model?.title
                if cellModel.isSelected == true {
                    label.backgroundColor = #colorLiteral(red: 0.9121555686, green: 0.9691887498, blue: 0.9528110623, alpha: 1)
                    label.textColor = .color_Theme()
                }
                else {
                    label.backgroundColor = #colorLiteral(red: 0.9605508447, green: 0.9646353126, blue: 0.9727998376, alpha: 1)
                    label.textColor = .black
                }
            }
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.layer.cornerRadius = 17.5
        label.layer.masksToBounds = true
        label.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
