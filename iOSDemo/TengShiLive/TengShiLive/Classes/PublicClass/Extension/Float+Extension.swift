//
//  Float+Extension.swift
//  quanzi
//
//  Created by penguin on 2019/10/21.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension Float {
    
    
    /// 数量单位转换
    var quantityUnitConversion: String {
        // 万
        let unit_W:String = "w"
        //        // 亿
        //        let unit_Y:String = "亿"
        //
        //        if (self / 100000000) > 1 {
        //
        //                   let temp = self / 100000000
        //
        //                   if fmodf(Float(temp), 1) == 0 {
        //
        //                       let str = String.init(format: "%.0f", temp)
        //
        //                       return str + unit_Y
        //
        //                   }else if fmodf(Float(temp) * 10, 1) == 0 {
        //
        //                       let str = String.init(format: "%.1f", temp)
        //
        //                       return str + unit_Y
        //
        //                   }else{
        //
        //                       let str = String.init(format: "%.2f", temp)
        //                       let decimal = str.components(separatedBy: ".")
        //                       let arrayString = decimal[1]
        //
        //                       if arrayString == "00" {
        //
        //                           return decimal[0] + unit_Y
        //                       }
        //
        //                       return str + unit_Y
        //                   }
        //
        //               }
        
        if (self / 10000) > 1 {
            
            let temp = self / 10000
            
            if fmodf(Float(temp), 1) == 0 {
                
                let str = String.init(format: "%.0f", temp)
                
                return str + unit_W
                
            }else if fmodf(Float(temp) * 10, 1) == 0 {
                
                let str = String.init(format: "%.1f", temp)
                
                return str + unit_W
                
            }else{
                
                let str = String.init(format: "%.2f", temp)
                let decimal = str.components(separatedBy: ".")
                
                let arrayString = decimal[1]
                
                if arrayString == "00" {
                    
                    return decimal[0] + unit_W
                }
                
                return str + unit_W
                
            }
            
        }
        
        
        
        let decimal = String.init(self).components(separatedBy: ".")
        
        let arrayString = decimal[1]
        
        if arrayString == "0" {
            
            return decimal[0]
        }
        
        return String.init(self)
        
    }
    
}
