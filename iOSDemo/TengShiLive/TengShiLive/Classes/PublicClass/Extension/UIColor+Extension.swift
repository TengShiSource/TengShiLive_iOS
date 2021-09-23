//
//  UIColor+Extension.swift
//
//  Created by penguin on 2019/5/28.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit
//MARK: 基础颜色
let color_black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
let color_white = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
let color_gray = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
let color_red = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
let color_orange = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
let color_blue = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
let color_green = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
let color_blue2 = #colorLiteral(red: 0.2784313725, green: 0.3921568627, blue: 0.8156862745, alpha: 1)
let color_blue3 = #colorLiteral(red: 0.1844414771, green: 0.6659726501, blue: 0.9280208945, alpha: 1)
let color_blue4 = #colorLiteral(red: 0.1544730067, green: 0.4423713684, blue: 0.6749771237, alpha: 1)
let color_blue5 = #colorLiteral(red: 0.2246459126, green: 0.7731027007, blue: 0.9982408881, alpha: 1)

let color_orange2 = #colorLiteral(red: 1, green: 0.7764705882, blue: 0, alpha: 1)
// 直播节目深黑色
let color_black2 = #colorLiteral(red: 0.1488672197, green: 0.1528193057, blue: 0.1611176431, alpha: 1)
// 直播节目浅黑色
let color_black3 = #colorLiteral(red: 0.2701669335, green: 0.2820392847, blue: 0.3028204739, alpha: 1)
// 直播节目菜单透明黑
let color_black4 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)

let color_black5 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)

let color_red2 = #colorLiteral(red: 1, green: 0.4156862745, blue: 0.4156862745, alpha: 1)

let color_gray2 = #colorLiteral(red: 0.9605508447, green: 0.9646353126, blue: 0.9727998376, alpha: 1)
let color_gray3 = #colorLiteral(red: 0.6037368178, green: 0.6078248024, blue: 0.6118959785, alpha: 1)

let color_green2 = #colorLiteral(red: 0.8126372695, green: 0.9225896001, blue: 0.8899760842, alpha: 1)

let color_white2 = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)

let color_Theme1 = #colorLiteral(red: 0.1532616615, green: 0.6976590753, blue: 0.5465596318, alpha: 1)

//MARK: 颜色扩展
extension UIColor {
    
    //MARK: 随机颜色
    /// 随机颜色
    ///
    /// - Returns: 颜色
    class func color_Random() -> (UIColor) {
        return UIColor.init(red: CGFloat(arc4random()%255)/255.0,
                            green: CGFloat(arc4random()%255)/255.0,
                            blue: CGFloat(arc4random()%255)/255.0,
                            alpha: 1)
    }
    
    //MARK: RGB 颜色
    /// RGB 颜色
    ///
    /// - Returns: 颜色
    class func color(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) -> (UIColor) {
        
        return UIColor.init(red: red/255.0,
                            green: green/255.0,
                            blue: blue/255.0,
                            alpha: alpha)
        
    }
    
    //MARK: 主题颜色
    /// 主题颜色
    /// - Returns: 颜色
    class func color_Theme() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return #colorLiteral(red: 0.1532616615, green: 0.6976590753, blue: 0.5465596318, alpha: 1)
                }
                else {
                    // 浅色模式
                    return #colorLiteral(red: 0.1532616615, green: 0.6976590753, blue: 0.5465596318, alpha: 1)
                }
            }
        }
        else {
            return #colorLiteral(red: 0.1532616615, green: 0.6976590753, blue: 0.5465596318, alpha: 1)
        }
    }
    
    //MARK: 背景颜色
    /// 背景颜色
    ///
    /// - Returns: 颜色
    class func color_Background() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_black
                }
                else {
                    // 浅色模式
                    return color_white
                }
            }
        }
        else {
            return color_white
        }
    }
    
    //MARK: Cell背景颜色
    /// Cell背景颜色
    ///
    /// - Returns: 颜色
    class func color_tableView_Background() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_gray2
                }
                else {
                    // 浅色模式
                    return color_gray2
                }
            }
        }
        else {
            return color_gray2
        }
    }
    
    //MARK: Cell背景颜色
    /// Cell背景颜色
    ///
    /// - Returns: 颜色
    class func color_cell_Background() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式      
                    return color_black2
                }
                else {
                    // 浅色模式
                    return color_white2
                }
            }
        }
        else {
            return color_white2
        }
    }
    
    //MARK: 文本颜色
    /// 文本颜色(黑白)
    ///
    /// - Returns: 颜色
    class func color_text() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_white
                }
                else {
                    // 浅色模式
                    return color_black
                }
            }
        }
        else {
            return color_black
        }
    }
    
    //MARK: 选中文本颜色
    /// 选中文本颜色
    ///
    /// - Returns: 背景色
    class func color_text_selected() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_red2
                }
                else {
                    // 浅色模式
                    return color_black
                }
            }
        }
        else {
            return color_black
        }
    }
    
    //MARK: 文本颜色
    /// 文本颜色
    ///
    /// - Returns: 颜色
    class func color_text_gray() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_gray3
                }
                else {
                    // 浅色模式
                    return color_gray3
                }
            }
        }
        else {
            return color_gray3
        }
    }
    
    //MARK: 按钮颜色
    /// 按钮颜色
    ///
    /// - Returns: 按钮颜色
    class func color_Button() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_Theme1
                }
                else {
                    // 浅色模式
                    return color_Theme1
                }
            }
        }
        else {
            return color_Theme1
        }
    }
    
    //MARK: 分隔线
    /// 分隔线
    ///
    /// - Returns: 颜色
    class func color_line() -> UIColor {
        return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    //MARK: Tabbar图标和字体颜色
    /// Tabbar图标和字体颜色
    ///
    /// - Returns: 颜色
    class func color_tabbar_icon() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_black2
                }
                else {
                    // 浅色模式
                    return color_black2
                }
            }
        }
        else {
            return color_black2
        }
    }
    //MARK: Tabbar选中状态的图标和字体颜色
    /// Tabbar选中状态的图标和字体颜色
    ///
    /// - Returns: 颜色
    class func color_tabbar_icon_selected() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_blue2
                }
                else {
                    // 浅色模式
                    return color_blue2
                }
            }
        }
        else {
            return color_blue2
        }
    }
    
    //MARK: Tabbar背景颜色
    /// Tabbar背景颜色
    ///
    /// - Returns: 颜色
    class func color_tabbar_background() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_blue2
                }
                else {
                    // 浅色模式
                    return color_white
                }
            }
        }
        else {
            return color_white
        }
    }
    
    //MARK: 导航返回按钮文字颜色
    /// Tabbar背景颜色
    ///
    /// - Returns: 颜色
    class func color_navigation_backButton() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    //深色模式
                    return color_blue2
                }
                else {
                    // 浅色模式
                    return color_white
                }
            }
        }
        else {
            return color_white
        }
    }
}
