//
//  UILabel+Extension.swift
//
//  Created by penguin on 2019/6/20.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    //MARK:遍历构造
    
    /// 快速构建
    ///
    /// - Parameters:
    ///   - frame: 坐标
    ///   - text: 文字
    ///   - font: 字体
    ///   - textAlignment: 对齐方式
    ///   - textColor: 字体颜色
    /// - Returns: 实例
    func create(frame:CGRect,
                text:String,
                font:UIFont,
                textAlignment:NSTextAlignment,
                textColor:UIColor) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = font
        label.textAlignment = textAlignment
        label.textColor = textColor
        return label
    }
    
    //    /// 设置字体
    //    NSAttributedString.Key.font
    //    /// 设置段落风格
    //    NSAttributedString.Key.paragraphStyle
    //    /// 设置文本颜色
    //    NSAttributedString.Key.foregroundColor
    //    /// 设置背景颜色
    //    NSAttributedString.Key.backgroundColor
    //    /// 设置下划线颜色
    //    NSAttributedString.Key.underlineColor
    //    /// 设置下划线样式
    //    NSAttributedString.Key.underlineStyle
    //    /// 设置阴影
    //    NSAttributedString.Key.shadow
    //    /// 设置超链接
    //    NSAttributedString.Key.link
    
    //MARK:UILabel设置属性字符串
    
    /// 字体循环标红（搜索中使用，signs中元素格式为服务器给定好的）
    func setting(text:String, signs:[[String:Int]]) {
        if signs.count>0 {
            let attributedString:NSMutableAttributedString  = NSMutableAttributedString(string: text)
            
            //（sign格式为字典（key: b为开始位置 e为结束位置 l为长度））
            for dict in signs {
                if let location = dict["b"], let length = dict["l"] {
                    let range = NSRange(location: location, length: length)
                    attributedString.setAttributes([NSAttributedString.Key.foregroundColor:UIColor.red],
                                                   range: range)
                }
                else{
                    AppPrint(#function + "解析错误")
                }
            }
            self.attributedText = attributedString
        }
        else{
            self.text = text
        }
    }
    
    /// 字体标记高亮颜色（颜色aColor为标记的颜色 aSigns中元素格式为NSRange(NSValue.rangeValue)）
    func setting(text:String, signs:[[String:Int]], color:UIColor) {
        if signs.count>0 {
            let attributedString:NSMutableAttributedString  = NSMutableAttributedString(string: text)
            
            //（sign格式为字典（key: b为开始位置 e为结束位置 l为长度））
            for dict in signs {
                if let location = dict["b"], let length = dict["l"] {
                    let range = NSRange(location: location, length: length)
                    attributedString.setAttributes([NSAttributedString.Key.foregroundColor:color],
                                                   range: range)
                }
                else{
                    AppPrint(#function + "解析错误")
                }
            }
            self.attributedText = attributedString
        }
        else{
            self.text = text
        }
    }
    
    /// 字体标记高亮颜色（颜色aColor为标记的颜色 aSigns中元素格式为NSRange）
    func setting(text:String, signs:[NSRange], color:UIColor, font:UIFont) {
        if signs.count>0 {
            let attributedString:NSMutableAttributedString  = NSMutableAttributedString(string: text)
            
            for range in signs {
                attributedString.setAttributes([NSAttributedString.Key.foregroundColor:color],
                                               range: range)
                attributedString.addAttributes([NSAttributedString.Key.font:font],
                                               range: range)
            }
            
            self.attributedText = attributedString
        }
        else{
            self.text = text
        }
    }
    
}
