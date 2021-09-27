//
//  UIAlertController+Extension.swift
//
//  Created by penguin on 2019/5/31.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    /// 默认以window.根视图控制器呈现
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    class func show(title:String, message:String?) {
        let alertVC:UIAlertController = UIAlertController(title: title,
                                                          message: message,
                                                          preferredStyle: UIAlertController.Style.alert)
        alertVC.addAction(UIAlertAction(title: "确定",
                                        style: UIAlertAction.Style.default,
                                        handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
    
    /// 打印错误信息 默认以window.根视图控制器呈现
    ///
    /// - Parameters:
    ///   - error: 目标对象
    ///   - viewController: 控制器
    class func show(error:Error?) {
        let message:String = "错误码:\(String(describing: error)))"
        let alertVC:UIAlertController = UIAlertController(title: "请求失败",
                                                          message: message,
                                                          preferredStyle: UIAlertController.Style.alert)
        alertVC.addAction(UIAlertAction(title: "确定",
                                        style: UIAlertAction.Style.default,
                                        handler: nil))
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
    
}
