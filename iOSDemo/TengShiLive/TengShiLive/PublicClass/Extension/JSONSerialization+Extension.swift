//
//  JSONSerialization+Extension.swift
//
//  Created by penguin on 2019/6/5.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation

extension JSONSerialization {
    
    /// 字典转JSON字符型
    ///
    /// - Parameter object: 字典
    /// - Returns: JSON字符串
    class func JSONString(object:Any) -> String {
        var jsonString : String = ""
        if (!JSONSerialization.isValidJSONObject(object)) {
            print("无法解析出JSONString")
            return jsonString
        }
        if let jsonData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted){
            
            jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8) ?? ""
        }
        return jsonString
    }
}
