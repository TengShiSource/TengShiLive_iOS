//
//  UIButton+Extension.swift
//  quanzi
//
//  Created by penguin on 2019/10/14.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    /// 图片加文字
    class func createTextAndImageButton(target:Any,
                                   action:Selector,
                                   title:String,
                                   normalImage:String,
                                   selectedImage:String) -> UIButton {
        let button:UIButton = UIButton.init(type: .custom)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
        button.setTitleColor(UIColor.color_Button(), for: UIControl.State.selected)
        button.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle(title, for: UIControl.State.normal)
        button.setImage(UIImage(named:normalImage), for: UIControl.State.normal)
        button.setImage(UIImage(named:selectedImage), for: UIControl.State.selected)
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return button
    }
    
    /// 自定义图片的按钮
    class func createButton(target:Any,
                            action:Selector,
                            image:String) -> UIButton {
        // 图片
        let button:UIButton = UIButton.init(type: .system)
        button.setImage(UIImage(named:image), for: UIControl.State.normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return button
    }
    
    /// 自定义图片的按钮
    class func createButton(target:Any,
                            action:Selector,
                            normalImage:String,
                            selectedImage:String,
                            disabledImage:String?) -> UIButton {
        // 图片
        let button:UIButton = UIButton.init(type: .custom)
        button.setImage(UIImage(named:normalImage), for: UIControl.State.normal)
        button.setImage(UIImage(named:selectedImage), for: UIControl.State.selected)
        if let disabled = disabledImage {
            button.setImage(UIImage(named:disabled), for: UIControl.State.disabled)
        }
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return button
    }

    /// 返回按钮(黑色)
    class func backButtonBlack(target:Any,
                               action:Selector) -> UIButton {
        // 图片
        let image:UIImage? = UIImage(named:"返回-黑")
        let button:UIButton = UIButton.init(type: .system)
        button.setImage(image, for: UIControl.State.normal)
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return button
    }
    
    /// 返回按钮(白色)
    class func backButtonWhite(target:Any,
                               action:Selector) -> UIButton {
        // 图片
        let image:UIImage? = UIImage(named:"返回-白")
        let button:UIButton = UIButton.init(type: .system)
        button.setImage(image, for: UIControl.State.normal)
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return button
    }
    
}
