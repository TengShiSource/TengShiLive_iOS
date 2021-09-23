//
//  UIView+Extension.swift
//
//  Created by penguin on 2019/6/13.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var allSubViews : [UIView] {

            var array = [self.subviews].flatMap {$0}

            array.forEach { array.append(contentsOf: $0.allSubViews) }

            return array
        }
    
    //MARK: 设置 UIView 坐标系取值
    
    /// 设置center x
    func setCenter(x:CGFloat) {
        var c = self.center
        c.y = x
        self.center = c
    }
    /// 设置center y
    func setCenter(y:CGFloat) {
        var c = self.center
        c.y = y
        self.center = c
    }
    /// 设置frame y
    func setFrame(y:CGFloat) {
        var f = self.frame
        f.origin.y = y
        self.frame = f
    }
    /// 设置frame x
    func setFrame(x:CGFloat) {
        var f = self.frame
        f.origin.x = x
        self.frame = f
    }
    /// 设置frame width
    func setFrame(width:CGFloat) {
        var f = self.frame
        f.size.width = width
        self.frame = f
    }
    /// 设置frame height
    func setFrame(height:CGFloat) {
        var f = self.frame
        f.size.height = height
        self.frame = f
    }
    /// 设置frame size
    func setFrame(size:CGSize) {
        var f = self.frame
        f.size = size
        self.frame = f
    }
    
    //MARK: 获取 UIView 坐标系取值
    
    /// X坐标
    func frame_x() -> CGFloat {
        return self.frame.origin.x
    }
    
    /// Y坐标
    func frame_y() -> CGFloat {
        return self.frame.origin.y
    }
    
    //宽度
    func frame_width() -> CGFloat {
        return self.frame.size.width
    }
    
    //高度
    func frame_height() -> CGFloat {
        return self.frame.size.height
    }
    
    ///底部坐标
    func frame_bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    ///右侧末尾坐标
    func frame_trailing() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    //    ///左侧末尾坐标
    //    func frame_leading() -> CGFloat {
    //        return self.frame.origin.x + self.frame.size.width
    //    }
    
    /// 设置部分圆角(绝对布局)
    ///
    /// - Parameters:
    ///   - corners: 需要设置为圆角的角 [.topLeft, .topRight, .bottomLeft, .bottomRight, .allCorners]
    ///   - radii: 需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
    func addRounded(corners:UIRectCorner, radii:CGSize) {
        let rounded = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
    
    /// 设置部分圆角(相对布局)
    ///
    /// - Parameters:
    ///   - corners: 需要设置为圆角的角 [.topLeft, .topRight, .bottomLeft, .bottomRight, .allCorners]
    ///   - radii: 需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
    ///   - rect: 需要设置的圆角view的rect
    func addRounded(corners:UIRectCorner, radii:CGSize, rect:CGRect) {
        let rounded = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
    
    //// UIView 转图片
    ///
    /// - Returns: 转换后的图片
    func changeToUIImage() -> UIImage? {
        let s = self.bounds.size
        // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的
        // 如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(s, false, UIScreen.main.scale)
        if let context:CGContext = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        else{
            return nil
        }
    }
    
//    //将当前视图转为UIImage
//    func asImage() -> UIImage {
//        let renderer = UIGraphicsImageRenderer(bounds: bounds)
//        return renderer.image { rendererContext in
//            layer.render(in: rendererContext.cgContext)
//        }
//    }
    
    
}
