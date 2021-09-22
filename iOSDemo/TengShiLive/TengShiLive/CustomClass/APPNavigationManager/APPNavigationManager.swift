//
//  APPNavigationManager.swift
//
//  Created by penguin on 2019/5/29.
//  Copyright © 2019 Penguin. All rights reserved.
//

import UIKit

class APPNavigationManager: NSObject {
    
    //MARK: 切换到引导页
    class func replaceToGuidePage() -> () {
        let VC = APPGuidePageViewController()
        UIApplication.shared.windows.first?.rootViewController = VC
    }
    
    //MARK: 切换到主页
    class func replaceToHomePage() -> () {
        let VC = LoginClassroomViewController()
        let NC = BaseNavigationController.init(rootViewController: VC)
        UIApplication.shared.windows.first?.rootViewController = NC
    }
}
