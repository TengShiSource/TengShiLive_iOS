//
//  String+Extension.swift
//
//  Created by penguin on 2019/5/31.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// 去掉前后的空格
    func clearSpace() -> String {
        let whitespace:CharacterSet = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    
    /// 去掉所有空格
    func clearAllSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    /// 去掉所有字符
    func clearAllSymbol(string:String) -> String {
        return self.replacingOccurrences(of: string, with: "")
    }
    
    
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
    
    /// 将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    /// 将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    //MARK: ------------正则表达式-----------
    
    /// 判断是否是一个有效的邮箱地址
    func validateEmail() -> Bool {
        let emailCheck = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate.init(format: "SELF MATCHES %@", emailCheck)
        return emailTest.evaluate(with: self)
    }
    
    /// 验证是否是固话或者手机
    func validatePhoneNumberAndTel() -> Bool {
        let telNum = "^(0([0-9])\\d{9,10})$"
        let phoneNum = "^(1([0-9])\\d{9})$"
        let regextestTel = NSPredicate.init(format: "SELF MATCHES %@", telNum)
        let regextestPhone = NSPredicate.init(format: "SELF MATCHES %@", phoneNum)
        
        if regextestTel.evaluate(with: self) || regextestPhone.evaluate(with: self) {
            return true
        }
        else{
            return false
        }
    }
    
    /// 验证是不是手机号(不包括电话号 规则1开头的十一位就行)
    func validateMobile() -> Bool {
        let phoneRegex = "^(1([0-9])\\d{9})$"
        let phoneTest = NSPredicate.init(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    /// 车牌号验证
    func validateCarNo() -> Bool {
        let carRegex = "^[\u{4e00}-\u{9fa5}]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u{4e00}-\u{9fa5}]$"
        let carTest = NSPredicate.init(format: "SELF MATCHES %@", carRegex)
        return carTest.evaluate(with: self)
    }
    
    /// 车型
    func validateCarType() -> Bool {
        let CarTypeRegex = "^[\u{4E00}-\u{9FFF}]+$"
        let carTest = NSPredicate.init(format: "SELF MATCHES %@", CarTypeRegex)
        return carTest.evaluate(with: self)
    }
    
    /// 用户名
    func validateUserName() -> Bool {
        let userNameRegex = "^[._%+-@A-Za-z0-9]{1,30}+$"
        let userNamePredicate = NSPredicate.init(format: "SELF MATCHES %@", userNameRegex)
        return userNamePredicate.evaluate(with: self)
    }
    
    /// 密码
    func validatePassword() -> Bool {
        let passWordRegex = "^[_a-zA-Z0-9]{6,20}+$"
        let passWordPredicate = NSPredicate.init(format: "SELF MATCHES %@", passWordRegex)
        return passWordPredicate.evaluate(with: self)
    }

    /// 联系人姓名
    func validateNickname() -> Bool {
        let nicknameRegex = "^[a-zA-Z. \u{4e00}-\u{9fa5}]{0,20}$"
        let passWordPredicate = NSPredicate.init(format: "SELF MATCHES %@", nicknameRegex)
        return passWordPredicate.evaluate(with: self)
    }
    
    /// 身份证号
    func validateIdentityCard() -> Bool {
        let regex2 = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let identityCardPredicate = NSPredicate.init(format: "SELF MATCHES %@", regex2)
        return identityCardPredicate.evaluate(with: self)
    }
    
}
