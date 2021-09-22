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
}
