//
//  Date+Extension.swift
//
//  Created by penguin on 2019/6/3.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation

extension Date {
    
    /// 获取时间戳字符串（秒）
    func timestampStringS() -> String {
        return String(format: "%.0f", self.timeIntervalSince1970)
    }
    
    /// 获取时间戳字符串（毫秒）
    func timestampStringMS() -> String {
        return String(format: "%.0f", self.timeIntervalSince1970*1000)
    }
    
    /// 返回日期拼接 yyyyMMddHHmmssSSS
    func dateToDateString(dateFormat:String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.full
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone.init(identifier: "As/Shangiahai")
        let fixString = formatter.string(from: self)
        return fixString
    }
    
    /// 将时间转换成本地时区
    func getLocalWithDate() -> Date {
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: self)
        let localDate = self.addingTimeInterval(TimeInterval(interval))
        return localDate
    }
    
    /// 获取当前时间（本地时区的Date）
    static func localDate() -> Date {
        let date = Date()
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: date)
        let localDate = date.addingTimeInterval(TimeInterval(interval))
        return localDate
    }
    
    ///将时间显示为（几分钟前，几小时前，几天前）
    func dateToBeforeFormatString() -> String {
        //将时间戳转换为日期
        let currentDate = Date.localDate()
        
        let timeInterval = currentDate.timeIntervalSince(self)
        
        var temp:Double = 0
        
        var result:String = ""
        
        // 一分钟之前
        if timeInterval < 60 {
            result = "刚刚"
        }
        else if timeInterval < 60 * 60 {//一小时之前
            temp = timeInterval / 60
            result = "\(Int(temp))分钟前"
        }
        else if timeInterval/60 * 60 < 60 * 60 * 24 {// 1天之前
            temp = timeInterval / (60 * 60)
            result = "\(Int(temp))小时前"
        }
        else if timeInterval < 60 * 60 * 24 * 30 {// 一个月之前
            temp = timeInterval / (24 * 60 * 60)
            result = "\(Int(temp))天前"
        }
        else if timeInterval < 60 * 60 * 24 * 30 * 12 {// 一年之前
            temp = timeInterval/(60 * 60 * 24 * 30)
            result = "\(Int(temp))个月前"
        }
        else{
            temp = timeInterval/(60 * 60 * 24 * 30 * 12)
            result = "\(Int(temp))年前"
        }
        
        return result
        
    }
    
    
    
}
