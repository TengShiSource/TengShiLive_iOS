//
//  CombinationTextFieldView.swift
//  WangXiao
//
//  Created by penguin on 2021/6/2.
//

import UIKit

class CombinationTextFieldView: UIView {

    lazy var textField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 14)
        field.textColor = .black
        return field
    }()
    
    // 选填
    lazy var optionLabel: UILabel = {
        let label = UILabel()
        label.text = "（选填）"
        label.textAlignment = .right
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        addSubview(optionLabel)
        optionLabel.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(70)
            make.right.equalTo(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
