//
//  HUDManager.swift
//
//  Created by penguin on 2019/5/31.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation

import SVProgressHUD

/// 活动指示器管理
class HUDManager {
    
    class func showHUD() {
        /// 不允许用户操作，背景是透明的
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.show()
    }
    
    /// 允许用户操作，背景是透明的(页面消失时候需要手动结束)
    class func showHUDAllowInteraction() {
        /// 不允许用户操作，背景是透明的
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
        SVProgressHUD.show()
    }
    
    /// 显示一个自定义文字的
    /// - Parameter content: 文本
    class func showHUD(content:String) {
        /// 不允许用户操作，背景是透明的
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.show(withStatus: content)
    }
    
    /// 隐藏
    class func hiddenHUD() {
        SVProgressHUD.dismiss()
    }
    
    /// 显示一个失败的状态
    class func showHUDWithError(content:String) {
        /// 允许用户操作，背景是透明的
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.showError(withStatus: content)
    }
    /// 显示一个成功的状态
    class func showHUDWithSuccess(content:String) {
        /// 允许用户操作，背景是透明的
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.showSuccess(withStatus: content)
    }
    /// 显示一个信息的状态
    class func showHUDWithInfo(content:String) {
        /// 允许用户操作，背景是透明的
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.showInfo(withStatus: content)
    }
}
