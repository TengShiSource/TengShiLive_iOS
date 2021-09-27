//
//  SetClassroomViewController.swift
//  WangXiao
//
//  Created by penguin on 2021/6/2.
//

import UIKit
import ZLPhotoBrowser


@objc protocol SetClassroomViewControllerDelegate : NSObjectProtocol {
    ///
    @objc func setClassroomVCDidBack()
}

/// 设置课堂
class SetClassroomViewController: BaseViewController {
    
    weak var delegate:SetClassroomViewControllerDelegate?
    
    // 头像
    lazy var avatarLabel: UILabel = {
        let label = UILabel()
        label.text = "  头像"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.backgroundColor = .white
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        label.addGestureRecognizer(tap)
        return label
    }()
    @objc func tapAvatar() {
        
        let VC = AvatarListViewController()
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .orange
        imageView.sd_setImage(with: URL(string: APPSingleton.shared.userLogo),
                                    placeholderImage: UIImage(named: "Default_UserAvatar"))
        return imageView
    }()
    
    // 昵称
    lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "  昵称"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.backgroundColor = .white
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapNickName))
        label.addGestureRecognizer(tap)
        return label
    }()
    @objc func tapNickName() {
        print("修改昵称")
        let VC = APPTextFieldViewController()
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    lazy var nickNameContentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // 应用id（输入框）
    lazy var appIdView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholder = "请输入ID"
        return view
    }()
    
    // 应用秘钥 （输入框）
    lazy var appSecretView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholder = "请输入密钥"
        return view
    }()
    
    // 测试按钮
    lazy var testButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("测试", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.color_Theme(), for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.color_Theme().cgColor
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tapTestButton(sender:)), for: .touchUpInside)
        return button
    }()
    @objc func tapTestButton(sender:UIButton) {
        view.endEditing(true)
        sender.isEnabled = false
        if let appId = appIdView.textField.text,
           let appSecret = appSecretView.textField.text {
            
            HUDManager.showHUD(content: "验证中...")
            APPSingleton.shared.requestGetAppInfo { isSuccess, data, message, error in
                if isSuccess == true {
                    HUDManager.showHUDWithSuccess(content: "验证成功")
                    APPSingleton.shared.QMAPPID = appId
                    APPSingleton.shared.QMAPPSecret = appSecret
                }
                else {
                    HUDManager.showHUDWithError(content: "验证失败")
                }
                sender.isEnabled = true
            }
        }
        else {
            sender.isEnabled = true
        }
    }
    
    // 确定按钮
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("确定", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .color_Theme()
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tapDoneButton(sender:)), for: .touchUpInside)
        return button
    }()
    @objc func tapDoneButton(sender:UIButton) {
        view.endEditing(true)
        // 生成8位随机数
        let random = Int(arc4random_uniform(90000000) + 10000000)
        APPSingleton.shared.userId = random
//        //FIXME:测试
//        APPSingleton.shared.userId = 67005080
        self.delegate?.setClassroomVCDidBack()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(isTranslucent: false,
                         isHiddenNavigationBar: false,
                         animated: true)
    
        if APPSingleton.shared.nickname.count>0 {
            nickNameContentLabel.text = APPSingleton.shared.nickname
        }
        else {
            nickNameContentLabel.text = "未设置"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color_gray2
        createUI()
        
        appIdView.textField.text = APPSingleton.shared.QMAPPID
        appSecretView.textField.text = APPSingleton.shared.QMAPPSecret
    }
    
    func createUI() {
        navigationTitle(text: "设置")
        view.addSubview(avatarLabel)
        avatarLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
        }
        let arrow1 = UIImageView(image: UIImage(named: "右箭头"))
        arrow1.contentMode = .scaleAspectFit
        avatarLabel.addSubview(arrow1)
        arrow1.snp.makeConstraints { make in
            make.centerY.equalTo(avatarLabel)
            make.width.equalTo(15)
            make.height.equalTo(15)
            make.right.equalTo(-5)
        }
        avatarLabel.addSubview(avatarView)
        avatarView.layer.cornerRadius = 20
        avatarView.layer.masksToBounds = true
        avatarView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(avatarLabel)
            make.right.equalTo(arrow1.snp.left).offset(-5)
        }
        
        view.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarLabel.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
        }
        
        let arrow2 = UIImageView(image: UIImage(named: "右箭头"))
        arrow2.contentMode = .scaleAspectFit
        nickNameLabel.addSubview(arrow2)
        arrow2.snp.makeConstraints { make in
            make.centerY.equalTo(nickNameLabel)
            make.width.equalTo(15)
            make.height.equalTo(15)
            make.right.equalTo(-5)
        }
        
        nickNameLabel.addSubview(nickNameContentLabel)
        nickNameContentLabel.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(arrow2.snp.left).offset(-5)
            make.width.equalTo(nickNameLabel).multipliedBy(0.5)
        }
        
        let appIdLabel = UILabel()
        appIdLabel.text = "  应用ID"
        appIdLabel.textAlignment = .left
        appIdLabel.textColor = .black
        appIdLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(appIdLabel)
        appIdLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 80, height: 50))
            make.left.equalTo(15)
        }
        
        view.addSubview(appIdView)
        appIdView.snp.makeConstraints { make in
            make.top.equalTo(appIdLabel)
            make.bottom.equalTo(appIdLabel)
            make.left.equalTo(appIdLabel.snp.right)
            make.right.equalTo(-15)
        }
        
        let appKeyLabel = UILabel()
        appKeyLabel.text = "  应用密钥"
        appKeyLabel.textAlignment = .left
        appKeyLabel.textColor = .black
        appKeyLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(appKeyLabel)
        appKeyLabel.snp.makeConstraints { make in
            make.top.equalTo(appIdLabel.snp.bottom).offset(10)
            make.size.equalTo(appIdLabel)
            make.left.equalTo(appIdLabel)
        }
        view.addSubview(appSecretView)
        appSecretView.snp.makeConstraints { make in
            make.top.equalTo(appKeyLabel)
            make.bottom.equalTo(appKeyLabel)
            make.left.equalTo(appKeyLabel.snp.right)
            make.right.equalTo(-15)
        }
        
        view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.top.equalTo(appSecretView.snp.bottom).offset(15)
            make.height.equalTo(50)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(testButton.snp.bottom).offset(15)
            make.height.equalTo(50)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
    }
}

extension SetClassroomViewController:APPTextFieldViewControllerDelegate {
    func appTextFieldDidReturn(text: String, sign: Int, indexPaht: IndexPath) {
        APPSingleton.shared.nickname = text
        self.nickNameContentLabel.text = text
    }
}

extension SetClassroomViewController:AvatarListViewControllerDelegate {
    func avatarListDidSelected(imageURL: String) {
        APPSingleton.shared.userLogo = imageURL
        avatarView.sd_setImage(with: URL(string: imageURL),
                                    placeholderImage: UIImage(named: "Default_UserAvatar"))
    }
}
