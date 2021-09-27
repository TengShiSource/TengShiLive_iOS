//
//  UIScreen+Extension.swift
//
//  Created by penguin on 2019/5/29.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension UIScreen {
    
    /// 横向比例
    ///
    /// - Parameter width: 宽度述职
    /// - Returns: 比例计算后的值
    class func widthScale(width:CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width/414*(width)
    }
    
    /// 竖向比例
    ///
    /// - Parameter height: 高度数值
    /// - Returns: 比例计算后的值
    class func heightScale(height:CGFloat) -> CGFloat {
        return UIScreen.main.bounds.height/736*(height)
    }
    
}
