//
//  Array+Extension.swift
//  iOSDemo
//
//  Created by penguin on 2020/7/13.
//  Copyright © 2020 Penguin. All rights reserved.
//

import Foundation

extension Array {
    /// 下标方法处理数组越界(任意类型)
    subscript (safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
}

extension Array where Element: Equatable {

mutating func remove(_ object: Element) {
    if let index = firstIndex(of: object) {
        remove(at: index)
    }
}}
