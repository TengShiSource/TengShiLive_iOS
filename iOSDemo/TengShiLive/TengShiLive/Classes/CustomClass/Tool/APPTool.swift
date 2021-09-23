//
//  APPTool.swift
//  WangXiao
//
//  Created by penguin on 2021/6/4.
//

import Foundation

class APPTool {
    
    class func statusChangeToText(status:Int) -> String {
        switch status {
        case 0:do {
            return "未开始"
        }
        case 1:do {
            return "已开始"
        }
        case 2:do {
            return "正常结束"
        }
        case 3:do {
            return "老师在线超时结束"
        }
        case 4:do {
            return "未到结束"
        }
        case 5:do {
            return "课程时间超时结束"
        }
        default: do {
            return "未知"
        }
        }
    }
}
