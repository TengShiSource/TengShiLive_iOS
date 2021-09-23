//
//  StatusCode.swift
//
//  Created by penguin on 2019/6/3.
//  Copyright © 2019 Penguin. All rights reserved.
//

import UIKit

class StatusCode: NSObject {
    
    /// 请求成功succeed
    class func succeed(code:Int?) -> Bool {
        if code == 200 {
            return true
        }
        else{
            return false
        }
    }
    
    /// token错误
    class func tokenError(code:Int?) -> Bool {
        if code == 10 {
            return true
        }
        else{
            return false
        }
    }
    
}

