//
//  HistoryCourseCell.swift
//  WangXiao
//
//  Created by penguin on 2021/6/5.
//

import UIKit

/// 历史课程cell
class HistoryCourseCell: UITableViewCell {
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // 课程名称
    lazy var courseNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    // 时间🕒
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
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
        return label
    }()
    
    // 回放按钮
    lazy var replayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("精彩回放", for: .normal)
        button.backgroundColor = UIColor.color_Theme()
        return button
    }()
    
    var model:HistoryCourseModel? {
        didSet {
            if let cellModel = model {
                courseNameLabel.text = cellModel.courseName
                timeLabel.text = cellModel.startTime+" - "+cellModel.endTime
                pictureView.sd_setImage(with: URL(string: cellModel.avatarUrl),
                                            placeholderImage: UIImage(named: "Default_UserAvatar"))
                nameLabel.text = cellModel.nickName
                
                replayButton.isEnabled = false
                replayButton.backgroundColor = .lightGray
                
                if cellModel.videoUrl.count>0 {
                    replayButton.isEnabled = true
                    replayButton.backgroundColor = UIColor.color_Theme()
                }
                else {
                    replayButton.isEnabled = false
                    replayButton.backgroundColor = .lightGray
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = color_gray2
        contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        contentView.addSubview(courseNameLabel)
        courseNameLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }

        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(courseNameLabel.snp.bottom)
            make.left.equalTo(courseNameLabel).offset(25)
            make.right.equalTo(courseNameLabel)
            make.height.equalTo(25)
        }
        
        let timeView = UIImageView(image: UIImage(named: "时钟"))
        timeView.contentMode = .scaleAspectFit
        contentView.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.left.equalTo(courseNameLabel)
            make.size.equalTo(CGSize(width: 18, height: 18))
        }
        
        contentView.addSubview(pictureView)
        pictureView.layer.cornerRadius = 17.5
        pictureView.layer.masksToBounds = true
        pictureView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 35, height: 35))
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.left.equalTo(courseNameLabel)
        }
        let label = UILabel()
        label.text = "授课"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(pictureView)
            make.width.equalTo(contentView).multipliedBy(0.5)
            make.height.equalTo(pictureView).multipliedBy(0.5)
            make.left.equalTo(pictureView.snp.right).offset(10)
        }
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pictureView)
            make.size.equalTo(label)
            make.left.equalTo(label)
        }
        
        contentView.addSubview(replayButton)
        replayButton.layer.cornerRadius = 15
        replayButton.layer.masksToBounds = true
        replayButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 80, height: 30))
            make.right.equalTo(-25)
            make.bottom.equalTo(-25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
