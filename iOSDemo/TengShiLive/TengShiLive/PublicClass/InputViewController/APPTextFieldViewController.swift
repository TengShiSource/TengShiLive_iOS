//
//  APPTextFieldViewController.swift
//  WangXiao
//
//  Created by penguin on 2021/6/3.
//

import UIKit

@objc protocol APPTextFieldViewControllerDelegate : NSObjectProtocol {
    /// 返回的文本
    @objc func appTextFieldDidReturn(text:String, sign:Int, indexPaht:IndexPath)
}

class APPTextFieldViewController: BaseViewController {
    
    weak var delegate:APPTextFieldViewControllerDelegate?
    
    var sign:Int = 0
    var indexPath:IndexPath = IndexPath(row: 0, section: 0)
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "请输入内容"
        field.textColor = .black
        field.backgroundColor = .white
        return field
    }()

    // 确定按钮
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("确定", for: .normal)
        button.setTitleColor(UIColor.color_Theme(), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self,
                         action: #selector(tapDoneButton(sender:)),
                         for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.color_Theme().cgColor
        return button
    }()
    
    @objc func tapDoneButton(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.appTextFieldDidReturn(text: self.textField.text ?? "", sign: sign, indexPaht: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle(text: "输入页")
        view.backgroundColor = color_gray2
        
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(50)
        }
        
        // Do any additional setup after loading the view.
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
        }

        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
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
