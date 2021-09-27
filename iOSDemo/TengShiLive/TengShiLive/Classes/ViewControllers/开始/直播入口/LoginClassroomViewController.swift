//
//  LoginClassroomViewController.swift
//  WangXiao
//
//  Created by penguin on 2021/6/2.
//

import UIKit
import IQKeyboardManagerSwift

import TengShiLive_iOS

/// 登录课堂
class LoginClassroomViewController: BaseViewController {
    
    // 底图
    lazy var bottomView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "登录底图"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // 设置按钮
    lazy var setButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "登录设置"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self,
                         action: #selector(tapSetButton(sender:)),
                         for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    @objc func tapSetButton(sender:UIButton) {
        let VC = SetClassroomViewController()
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
    }
    // 分享按钮
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "登录分享"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self,
                         action: #selector(tapShareButton(sender:)),
                         for: .touchUpInside)
        return button
    }()
    @objc func tapShareButton(sender:UIButton) {
        // 调用分享
        let platforms = [NSNumber(integerLiteral:UMSocialPlatformType.QQ.rawValue)]
        UMShareSwiftInterface.setPreDefinePlatforms(platforms)
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        // 邀请人
        let text1 = "\(APPSingleton.shared.nickname)（邀请您进入课堂）\n"
        // 课堂名称
        let text2 = "课堂名称：\(APPSingleton.shared.QMCourseName))\n"
        // 创建时间
        let text3 = "创建时间：\(APPSingleton.shared.QMStartTime)\n"
        // 课堂编号
        let text4 = "课堂编号：\(APPSingleton.shared.QMCourseId)"

        //分享消息
        messageObject.text = text1+text2+text3+text4
        UMShareSwiftInterface.showShareMenuViewInWindowWithPlatformSelectionBlock { platformType, userInfo in
            UMShareSwiftInterface.share(plattype: platformType,
                                        messageObject: messageObject,
                                        viewController: self) { (data, error) in
                
            }
        }
    }
    // 顶部用户信息
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // icon
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // 标题
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "启明课堂"
        label.font = UIFont.systemFont(ofSize: 26)
        label.textAlignment = .center
        return label
    }()
    
    // 老师按钮
    lazy var teacherButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("教师", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "靶心按钮-N"), for: .normal)
        button.setImage(UIImage(named: "靶心按钮-S"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self,
                         action: #selector(tapRoleButton(sender:)),
                         for: .touchUpInside)
        button.isSelected = APPSingleton.shared.role == .teacher ? true : false
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return button
    }()
    // 学生按钮
    lazy var studentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("学生", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "靶心按钮-N"), for: .normal)
        button.setImage(UIImage(named: "靶心按钮-S"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        button.addTarget(self,
                         action: #selector(tapRoleButton(sender:)),
                         for: .touchUpInside)
        button.isSelected = APPSingleton.shared.role == .student ? true : false
        return button
    }()
    // 角色切换
    @objc func tapRoleButton(sender:UIButton) {
        if sender == teacherButton {
            APPSingleton.shared.role = .teacher
        }
        else {
            APPSingleton.shared.role = .student
        }
        refreshButtons()
    }
    // 根据角色刷新按钮
    func refreshButtons() {
        if APPSingleton.shared.role == .teacher {
            teacherButton.isSelected = true
            studentButton.isSelected = false
            joinButton.snp.removeConstraints()
            joinButton.snp.makeConstraints { make in
                make.top.equalTo(passwordFieldView.snp.bottom).offset(15)
                make.right.equalTo(-20)
                make.width.equalTo(view).multipliedBy(0.4)
                make.height.equalTo(50)
            }
        }
        else {
            teacherButton.isSelected = false
            studentButton.isSelected = true
            joinButton.snp.removeConstraints()
            joinButton.snp.makeConstraints { make in
                make.top.equalTo(passwordFieldView.snp.bottom).offset(15)
                make.right.equalTo(-20)
                make.left.equalTo(20)
                make.height.equalTo(50)
            }
        }
        if let text = numberFieldView.textField.text {
            if text.count > 0 {
                checkClassState(courseId: text)
            }
        }
    }
    
    
    // 课堂编号（输入框）
    lazy var numberFieldView: QMTextFieldView = {
        let view = QMTextFieldView()
        view.textField.placeholder = "请输入课堂编号"
        view.textField.keyboardType = .numberPad
        view.delegate = self
        return view
    }()
    
    // 密码（输入框）
    lazy var passwordFieldView: QMTextFieldView = {
        let view = QMTextFieldView()
        view.textField.placeholder = "请输入密码"
        //view.textField.isSecureTextEntry = true
        view.delegate = self
        return view
    }()
    
    // 课堂名称
    lazy var classNameLabel: UILabel = {
        let label = UILabel()
        label.text = "课堂名称：无"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    // 课堂状态
    lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.text = "上课中"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = UIColor.color_Theme()
        label.backgroundColor = color_green2
        return label
    }()
    // 创建课堂（按钮）
    lazy var createButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("创建课堂", for: .normal)
        button.setTitleColor(UIColor.color_Theme(), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self,
                         action: #selector(tapCreateButton(sender:)),
                         for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.color_Theme().cgColor
        return button
    }()
    @objc func tapCreateButton(sender:UIButton) {
        view.endEditing(true)
        let VC = CreateClassroomViewController()
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    // 进入课堂（按钮）
    lazy var joinButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("进入课堂", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.backgroundColor = .lightGray
        button.addTarget(self,
                         action: #selector(tapJoinButton(sender:)),
                         for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.isEnabled = false
        return button
    }()
    
    @objc func tapJoinButton(sender:UIButton) {
        //addStudents(students: [[:]])
        view.endEditing(true)
        // 注册用户
        registUser()
    }
    
    /// 注册用户
    func registUser() {
        let userid = APPSingleton.shared.userId
        let courseId:Int = APPSingleton.shared.QMCourseId
        let password:String = passwordFieldView.textField.text ?? ""
        APPSingleton.shared.requestRegistUser(userid: userid,
                                                courseId: courseId,
                                                password: password,
                                                nickName: APPSingleton.shared.nickname,
                                                role: APPSingleton.shared.role.rawValue,
                                                avatarUrl: APPSingleton.shared.userLogo,
                                                deviceToken: APPSingleton.shared.deviceToken,
                                                originExpValue: 0) { (isSuccess, data, message, error) in
            print(isSuccess)
            if isSuccess == true {
                // 绑定推送别名
                UMessageSwiftInterface.setAlias(name: String(userid), type: "Account") { (responseObject, error) in
                    print(responseObject as Any)
                    print(error as Any)
                }
                self.qmJoinClassroom()
            }
            else {
                HUDManager.showHUDWithError(content: message)
            }
        }
    }
    
    // 进入课堂
    func qmJoinClassroom() {
        print(APPSingleton.shared.QMToken)
        if APPSingleton.shared.QMToken.count>0 {

            QMManager.shared.qmJoinClassroom(ViewController: self,
                                             isTeacher: (APPSingleton.shared.role == .teacher ? true : false),
                                             token: APPSingleton.shared.QMToken)
            QMManager.shared.delegate = self
            // 控制是否显示键盘上的工具条
            IQKeyboardManager.shared.enableAutoToolbar = false
        }
        else {
            
        }
    }
    
    // 导入学生信息
    func addStudents(students:[[String:Any]]) {
        
        var tempStudents:[[String:Any]] = []
        for i in 0 ..< 3 {
            var student:[String:Any] = [:]
            student["id"] = "400\(i)"
            student["avatarUrl"] = ""
            student["nickName"] = "昵称\(i)"
            student["deviceToken"] = "deviceToken\(i)"
            student["expValue"] = 100
            tempStudents.append(student)
        }
        
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String:Any] = [:]
        parameters["students"] = tempStudents
        parameters["courseId"] = APPSingleton.shared.QMCourseId
        print(JSONSerialization.JSONString(object: parameters))
        manager.POSTRequest(URLString: INTERFACE_addStudents,
                            parameters: &parameters,
                            token: APPSingleton.shared.QMToken) { (requestData) in
            print(JSONSerialization.JSONString(object: requestData))

        } failure: { (error) in
            HUDManager.showHUDWithError(content: error.debugDescription)
        }
        
    }
    
    // 查看历史课程（按钮）
    lazy var historyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("查看历史课程", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "圆箭头"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self,
                         action: #selector(tapHistoryButton(sender:)),
                         for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 95, bottom: 3, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 20)
        return button
    }()
    @objc func tapHistoryButton(sender:UIButton) {
        let VC = HistoryCourseViewController()
        VC.userId = APPSingleton.shared.userId
        if APPSingleton.shared.role == .teacher {
            VC.userRole = "t"
        }
        else {
            VC.userRole = "s"
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //appDelegate.blockRotation = .portrait
        // 控制是否显示键盘上的工具条
        IQKeyboardManager.shared.enableAutoToolbar = true
        setNavigationBar(isTranslucent: true,
                         isHiddenNavigationBar: true,
                         animated: true)
        updateUI()
    }
    
    /// 刷新视图
    func updateUI() {
        if APPSingleton.shared.nickname.count>0 ||
            APPSingleton.shared.userId>0 {
            infoLabel.text = "用户ID："+String(APPSingleton.shared.userId)+"(\(APPSingleton.shared.nickname))"
        }
        else {
            infoLabel.text = "未设置"
        }
        if APPSingleton.shared.QMCourseId>0 {
            numberFieldView.textField.text = String(APPSingleton.shared.QMCourseId)
        }
    }
    /// 标记是否隐藏老师密码
    var isHiddenTPassword:Bool = false
    /// 标记是否隐藏学生密码
    var isHiddenSPassword:Bool = false
    //
    func updatePassword() {
        if APPSingleton.shared.role == .teacher {
            if isHiddenTPassword == false {
                passwordFieldView.textField.text = APPSingleton.shared.tPassword
                passwordFieldView.snp.updateConstraints { make in
                    make.height.equalTo(50)
                }
            }
            else {
                passwordFieldView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }
        }
        else {
            if isHiddenSPassword == false {
                passwordFieldView.textField.text = APPSingleton.shared.sPassword
                passwordFieldView.snp.updateConstraints { make in
                    make.height.equalTo(50)
                }
            }
            else {
                passwordFieldView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        updateLogoName()
        if APPSingleton.shared.QMAPPID.count<=0 ||
            APPSingleton.shared.userId<=0 {
            let VC = SetClassroomViewController()
            self.navigationController?.pushViewController(VC, animated: true)
        }
        if String(APPSingleton.shared.QMCourseId).count > 0 {
            checkClassState(courseId: String(APPSingleton.shared.QMCourseId))
        }
        refreshButtons()
    }
    // 动态显示logo和app名称
    func updateLogoName() {
        if APPSingleton.shared.QMAPPID.count>0 &&
            APPSingleton.shared.QMAPPSecret.count>0 {
            APPSingleton.shared.requestGetAppInfo { isSuccess, data, message, error in
                let appLogo = data?["appLogo"] as? String ?? ""
                let appName = data?["appName"] as? String ?? ""
                self.iconView.sd_setImage(with: URL(string: appLogo),
                                            placeholderImage: UIImage(named: "Default_UserAvatar"))
                self.titleLabel.text = appName
            }
        }
    }
    
    func createUI() {
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.right.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(view).multipliedBy(0.1)
        }
        
        view.addSubview(setButton)
        setButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(-15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.size.equalTo(setButton)
            make.top.equalTo(setButton)
            make.right.equalTo(setButton.snp.left)
        }
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(setButton)
            make.height.equalTo(setButton)
            make.left.equalTo(10)
            make.right.equalTo(shareButton.snp.left).offset(-10)
        }
        view.addSubview(iconView)
        iconView.layer.cornerRadius = 30
        iconView.layer.masksToBounds = true
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(UIScreen.main.bounds.height*0.15)
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.centerX.equalTo(view)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom)
            make.height.equalTo(40)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        view.addSubview(teacherButton)
        teacherButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.right.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 100, height: 25))
        }
        view.addSubview(studentButton)
        studentButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 100, height: 25))
        }
        view.addSubview(numberFieldView)
        numberFieldView.snp.makeConstraints { make in
            make.top.equalTo(teacherButton.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(passwordFieldView)
        passwordFieldView.snp.makeConstraints { make in
            make.top.equalTo(numberFieldView.snp.bottom).offset(40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        view.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(numberFieldView.snp.bottom).offset(5)
            make.right.equalTo(numberFieldView)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        setClassStatus(text: "未知")

        view.addSubview(classNameLabel)
        classNameLabel.snp.makeConstraints { make in
            make.top.equalTo(numberFieldView.snp.bottom).offset(5)
            make.left.equalTo(numberFieldView)
            make.right.equalTo(stateLabel.snp.left).offset(-10)
            make.height.equalTo(stateLabel)
        }
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.top.equalTo(passwordFieldView.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.width.equalTo(view).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        view.addSubview(joinButton)
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(passwordFieldView.snp.bottom).offset(15)
            make.right.equalTo(-20)
            make.width.equalTo(view).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.top.equalTo(joinButton.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 120, height: 20))
            make.centerX.equalTo(view)
        }
    }
    
    /// 设置状态
    /// - Parameter text: 文本
    func setClassStatus(text:String) {
        let w = text.sizeCalculate(font: UIFont.systemFont(ofSize: 10), maxSize: CGSize(width: 1000, height: 20)).width+10
        self.stateLabel.text = text
        self.stateLabel.snp.updateConstraints { make in
            make.width.equalTo(w)
        }
        self.stateLabel.addRounded(corners: [.topRight, .bottomLeft],
                               radii: CGSize(width: 5, height: 5),
                               rect:CGRect(x: 0, y: 0, width: w, height: 20))
    }

    /// 查询课堂状态
    func checkClassState(courseId:String) {
        APPSingleton.shared.requestGetCourseParam(courseId: courseId) { isSuccess, data, message, error in
            if isSuccess == true {
                // 课堂状态
                if let status = data?["status"] as? Int{
                    let text = APPTool.statusChangeToText(status: status)
                    self.setClassStatus(text: text)
                    if status == 1 ||
                        status == 0 {
                        self.joinButton.isEnabled = true
                        self.joinButton.backgroundColor = UIColor.color_Theme()
                    }
                    else {
                        self.joinButton.isEnabled = false
                        self.joinButton.backgroundColor = .lightGray
                    }
                }
                else {
                    self.joinButton.isEnabled = false
                    self.joinButton.backgroundColor = .lightGray
                }
                // 课堂名称
                if let courseName = data?["courseName"] as? String {
                    self.classNameLabel.text = courseName
                    APPSingleton.shared.QMCourseName = courseName
                }
                else {
                    self.classNameLabel.text = "课堂名称：无"
                    APPSingleton.shared.QMCourseName = ""
                }
                // 创建时间
                if let startTime = data?["startTime"] as? String {
                    APPSingleton.shared.QMStartTime = startTime
                }
                
                let tPassword = data?["teacherPwd"] as? String ?? ""
                let sPassword = data?["studentPwd"] as? String ?? ""
                self.isHiddenTPassword = tPassword.count>0 ? false : true
                self.isHiddenSPassword = sPassword.count>0 ? false : true
            }
            else {
                self.joinButton.isEnabled = false
                self.joinButton.backgroundColor = .lightGray
                self.classNameLabel.text = message
                self.setClassStatus(text: "未知")
            }
            self.updatePassword()
        }
    }
}
//
extension LoginClassroomViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == numberFieldView.textField {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                if updatedText.count>=8 {
                    //请求接口 查询信息
                    checkClassState(courseId: updatedText)
                }
                else {
                    setClassStatus(text: "未知")
                    self.classNameLabel.text = "课堂名称：无"
                }
                print(updatedText)
                if let courseId = Int(updatedText) {
                    APPSingleton.shared.QMCourseId = courseId
                }
            }
        }
        else if textField == passwordFieldView.textField {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                if APPSingleton.shared.role == .teacher {
                    APPSingleton.shared.tPassword = updatedText
                }
                else {
                    APPSingleton.shared.sPassword = updatedText
                }
            }
        }
        return true
    }
}

extension LoginClassroomViewController: CreateClassroomViewControllerDelegate {
    // 课程创建完成
    func createClassroomDidDone() {
        checkClassState(courseId: String(APPSingleton.shared.QMCourseId))
    }
}

extension LoginClassroomViewController:QMManagerDelegate {
    func changeScreen(orientation: UIInterfaceOrientationMask) {
        appDelegate.blockRotation = orientation
    }
    
    func classroomDidStop() {
        print("退出课堂成功")
        if let text = numberFieldView.textField.text {
            if text.count > 0 {
                checkClassState(courseId: text)
            }
        }
    }
    
    func onTICForceOffline() {
        
    }
    
    func onTICUserSigExpired() {
        
    }
    
    public func onEnterRoomFailed(code: Int, description: String) {
        
    }
}

extension LoginClassroomViewController:SetClassroomViewControllerDelegate {
    func setClassroomVCDidBack() {
        updateLogoName()
    }
}
