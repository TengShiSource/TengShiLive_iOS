//
//  UIBarButtonItem+Extension.swift
//
//  Created by penguin on 2019/5/28.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    /// 自定义返回按钮（黑色）
    ///
    /// - Parameters:
    ///   - target: 目标
    ///   - action: 方法
    /// - Returns: 实例
    class func createBackButtonItemBlack(target:Any,
                                         action:Selector) -> UIBarButtonItem {
        // 图片
        let image:UIImage? = UIImage(named:"返回-黑")
        let backBtn:UIButton = UIButton.init(type: UIButton.ButtonType.system)
        backBtn.frame = CGRect.init(x: 0, y: 0, width: image?.size.width ?? 0, height: 44.0)
        backBtn.setImage(image, for: UIControl.State.normal)
        backBtn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        let backItem:UIBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        return backItem
        
    }
    
    /// 自定义返回按钮（白色）
    ///
    /// - Parameters:
    ///   - target: 目标
    ///   - action: 方法
    /// - Returns: 实例
    class func createBackButtonItemWhite(target:Any,
                                         action:Selector) -> UIBarButtonItem {
        // 图片
        let image:UIImage? = UIImage(named:"返回-白")
        let backBtn:UIButton = UIButton.init(type: UIButton.ButtonType.system)
        backBtn.frame = CGRect.init(x: 0, y: 0, width: image?.size.width ?? 0, height: 44.0)
        backBtn.setImage(image, for: UIControl.State.normal)
        backBtn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        let backItem:UIBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        return backItem
        
    }
    
    /// 创建一个item
    ///
    /// - Parameters:
    ///   - target:             点击item后调用哪个对象的方法
    ///   - action:             点击item后调用target的哪个方法
    ///   - normalImage:        图片
    ///   - HighlightedImage:   高亮的图片
    /// - Returns: 实例
    class func item(target:Any,
                    action:Selector,
                    normalImage:String,
                    highlightedImage:String?) -> UIBarButtonItem {
        let button:UIButton = UIButton.init(type: UIButton.ButtonType.system)
        button.imageView?.contentMode = UIView.ContentMode.scaleToFill
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30.0)
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: normalImage), for: UIControl.State.normal)
        if let hImage = highlightedImage{
            button.setImage(UIImage(named: hImage), for: UIControl.State.highlighted)
        }
        let buttonItem:UIBarButtonItem = UIBarButtonItem(customView: button)
        return buttonItem
    }
    
    class func item(imageName:String) -> UIBarButtonItem {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.frame = CGRect.init(x: 0, y: 0, width: 55, height: 21.0)
        imageView.contentMode = .scaleAspectFit
        let buttonItem:UIBarButtonItem = UIBarButtonItem(customView: imageView)
        return buttonItem
    }
    
    /// 创建一个item
    ///
    /// - Parameters:
    ///   - target: 点击item后调用哪个对象的方法
    ///   - action: 点击item后调用target的哪个方法
    ///   - size: 大小
    ///   - normalImage: 图片
    ///   - HighlightedImage: 高亮的图片
    ///   - selectedImage: 选择状态的图片
    /// - Returns: 实例
    class func item(target:Any,
                    action:Selector,
                    size:CGSize,
                    normalImage:String,
                    HighlightedImage:String,
                    selectedImage:String) -> UIBarButtonItem {
        let button:UIButton = UIButton.init(type: UIButton.ButtonType.system)
        button.imageView?.contentMode = UIView.ContentMode.scaleToFill
        button.setFrame(size: size)
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: normalImage), for: UIControl.State.normal)
        button.setImage(UIImage(named: HighlightedImage), for: UIControl.State.highlighted)
        button.setImage(UIImage(named: selectedImage), for: UIControl.State.selected)
        button.imageView?.contentMode = .scaleAspectFit
        let buttonItem:UIBarButtonItem = UIBarButtonItem(customView: button)
        return buttonItem
    }
    
    class func item(target:Any,
                    action:Selector,
                    title:String,
                    color:UIColor) -> UIBarButtonItem {
        let button:UIButton = UIButton.init(type: UIButton.ButtonType.system)
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(color, for: UIControl.State.normal)
        /// 设置大小
        let size = title.sizeCalculate(font: UIFont.buttonFont(), maxSize: CGSize(width: 1000, height: 30))
        button.frame = CGRect(x: 0, y: 0, width: size.width, height: 30)
        button.titleLabel?.font = UIFont.buttonFont()
        let buttonItem:UIBarButtonItem = UIBarButtonItem(customView: button)
        return buttonItem
    }
    
    
    class func spaceitem() -> UIBarButtonItem {
        let item = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        return item
    }
    
}
