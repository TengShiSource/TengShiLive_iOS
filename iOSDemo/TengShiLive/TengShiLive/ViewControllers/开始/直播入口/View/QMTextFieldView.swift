//
//  QMTextFieldView.swift
//  WangXiao
//
//  Created by penguin on 2021/6/2.
//

import UIKit

class QMTextFieldView: UIView {
    
    weak var delegate:UITextFieldDelegate?

    lazy var textField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 14)
        field.delegate = self
        return field
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension QMTextFieldView:UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.color_Theme().cgColor
        self.delegate?.textFieldDidBeginEditing?(textField)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 <= 0 {
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
        self.delegate?.textFieldDidEndEditing?(textField)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return ((self.delegate?.textField?(textField,
                                           shouldChangeCharactersIn: range,
                                           replacementString: string)) != nil)
    }
}
