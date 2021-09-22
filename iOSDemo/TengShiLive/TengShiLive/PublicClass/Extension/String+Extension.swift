//
//  String+Extension.swift
//
//  Created by penguin on 2019/5/31.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// 将时间戳字符串转成时间
    func changeTimestamp() -> Date?{
        if let endtime = Double(self){
            let date = Date.init(timeIntervalSince1970: endtime)
            return date
        }
        else{
            print(#function + "字符串转换失败，格式错误")
            return nil
        }
    }
    
    /// 将时间戳字符串转成时间字符串(dateFormat = "yyyy-MM-dd")
    func changeTimestampString() -> String? {
        if let endtime = Double(self){
            let date = Date.init(timeIntervalSince1970: endtime)
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.init(identifier: "As/Shangiahai")
            formatter.locale = Locale.current
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
        else{
            print(#function + "字符串转换失败，格式错误")
            return nil
        }
    }
    
    /// 将时间戳字符串转成时间字符串(yyyyMMddHHmmssSSS)
    func changeTimestampString(formatString:String) -> String? {
        if let endtime = Double(self){
            let date = Date.init(timeIntervalSince1970: endtime)
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.init(identifier: "As/Shangiahai")
            formatter.locale = Locale.current
            formatter.dateFormat = formatString
            return formatter.string(from: date)
        }
        else{
            print(#function + "字符串转换失败，格式错误")
            return nil
        }
    }
    
    /// 字符串时间转Date  yyyy-MM-dd HH:mm:ss
    func stringToDate(formatString:String) -> Date? {
        let formatter = DateFormatter.init()
        formatter.dateStyle = DateFormatter.Style.none
        //yyyyMMddHHmmssSSS
        formatter.dateFormat = formatString
        if let result = formatter.date(from: self){
            return result
        }
        else{
            return nil
        }
    }
    
    /// 计算文字尺寸
    ///
    /// - Parameters:
    ///   - font: 文字的字体
    ///   - maxSize: 文字的最大尺寸
    /// - Returns: 返回文字的尺寸
    func sizeCalculate(font:UIFont, maxSize:CGSize) -> CGSize {
        let attrs = [NSAttributedString.Key.font : font]
        return NSString(string: self).boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }
}
