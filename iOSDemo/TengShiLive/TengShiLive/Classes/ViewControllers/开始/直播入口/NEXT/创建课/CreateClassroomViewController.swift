//
//  CreateClassroomViewController.swift
//  WangXiao
//
//  Created by penguin on 2021/6/2.
//

import UIKit

@objc protocol CreateClassroomViewControllerDelegate : NSObjectProtocol {
    ///
    @objc func createClassroomDidDone()
    
}

/// 创建课堂
class CreateClassroomViewController: BaseViewController {
    
    weak var delegate:CreateClassroomViewControllerDelegate?
    
    // 课堂名称（输入框）
    lazy var nameView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholder = "请输入课堂名称"
        return view
    }()
    // 教师密码
    lazy var tPasswordView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholder = "请输入教师登录密码"
        view.optionLabel.isHidden = false
        return view
    }()
    // 学生密码
    lazy var sPasswordView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholder = "请输入学生登录密码"
        view.optionLabel.isHidden = false
        return view
    }()
    // 课程时长
    lazy var timeView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholder = "请输入课程时长（分），默认60分"
        view.textField.keyboardType = .numberPad
        view.optionLabel.isHidden = false
        return view
    }()

    // 自动录制
    lazy var autoRecordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 5000
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("自动录制", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "靶心按钮-N"), for: .normal)
        button.setImage(UIImage(named: "靶心按钮-S"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self,
                         action: #selector(tapRecordButton(sender:)),
                         for: .touchUpInside)
        button.isSelected = true
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return button
    }()
    // 手动录制
    lazy var manualRecordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 5001
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("手动录制", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "靶心按钮-N"), for: .normal)
        button.setImage(UIImage(named: "靶心按钮-S"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self,
                         action: #selector(tapRecordButton(sender:)),
                         for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return button
    }()
    // 不录制
    lazy var notRecordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 5002
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("不录制", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "靶心按钮-N"), for: .normal)
        button.setImage(UIImage(named: "靶心按钮-S"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self,
                         action: #selector(tapRecordButton(sender:)),
                         for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return button
    }()
    
    var recMethod:Int = 1
    @objc func tapRecordButton(sender:UIButton) {
        // 1自动（默认） 2手动 3不录
        for tag in 5000 ..< 5003 {
            print(tag)
            if let button = view.viewWithTag(tag) as? UIButton {
                if button == sender {
                    recMethod = tag-5000+1
                    button.isSelected = true
                }
                else {
                    button.isSelected = false
                }
            }
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
        createCourse()
    }
    
    // 创建课
    func createCourse() {
        if nameView.textField.text?.count ?? 0 > 0 {
            
            HUDManager.showHUD(content: "创建中...")
            let name = nameView.textField.text ?? ""
            let appId:String = APPSingleton.shared.QMAPPID
            let tPassword = tPasswordView.textField.text ?? ""
            let sPassword = sPasswordView.textField.text ?? ""
            let courseOptions:[String:Any] = ["recMethod":recMethod,
                                             "openClassReminder":"y",
                                             "callbackUrl":"http://jledu.f3322.net:9208/live/test/callback"]
            APPSingleton.shared.requestCreateCourse(appId: appId,
                                                    courseName: name,
                                                    teacherPwd: tPassword,
                                                    studentPwd: sPassword,
                                                    startTime: "",
                                                    endTime: "",
                                                    courseOptions: courseOptions) { (isSuccess, data, message, error) in
                if isSuccess == true {
                    HUDManager.showHUDWithSuccess(content: "创建成功")
                    self.delegate?.createClassroomDidDone()
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    HUDManager.showHUDWithError(content: "创建失败")
                }
            }
        }
        else {
            HUDManager.showHUDWithError(content: "课堂名称不能为空")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle(text: "创建课")
        view.backgroundColor = color_gray2
        
        view.addSubview(nameView)
        nameView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
        }
        view.addSubview(tPasswordView)
        tPasswordView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.left.equalTo(nameView)
            make.right.equalTo(nameView)
            make.height.equalTo(nameView)
        }
        view.addSubview(sPasswordView)
        sPasswordView.snp.makeConstraints { make in
            make.top.equalTo(tPasswordView.snp.bottom).offset(10)
            make.left.equalTo(nameView)
            make.right.equalTo(nameView)
            make.height.equalTo(nameView)
        }
        view.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.top.equalTo(sPasswordView.snp.bottom).offset(10)
            make.left.equalTo(nameView)
            make.right.equalTo(nameView)
            make.height.equalTo(nameView)
        }
        
        view.addSubview(manualRecordButton)
        manualRecordButton.snp.makeConstraints { make in
            make.top.equalTo(timeView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.3)
            make.height.equalTo(25)
        }
        view.addSubview(autoRecordButton)
        autoRecordButton.snp.makeConstraints { make in
            make.top.equalTo(manualRecordButton)
            make.right.equalTo(manualRecordButton.snp.left)
            make.width.equalTo(manualRecordButton)
            make.height.equalTo(manualRecordButton)
        }

        view.addSubview(notRecordButton)
        notRecordButton.snp.makeConstraints { make in
            make.top.equalTo(manualRecordButton)
            make.left.equalTo(manualRecordButton.snp.right)
            make.width.equalTo(manualRecordButton)
            make.height.equalTo(manualRecordButton)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(manualRecordButton.snp.bottom).offset(20)
            make.left.equalTo(timeView)
            make.right.equalTo(timeView)
            make.height.equalTo(timeView)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(isTranslucent: false,
                         isHiddenNavigationBar: false,
                         animated: true)
    }
}
