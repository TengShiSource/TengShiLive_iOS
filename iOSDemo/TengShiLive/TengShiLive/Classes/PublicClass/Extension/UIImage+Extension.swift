//
//  UIImage+Extension.swift
//
//  Created by penguin on 2019/6/21.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /// 创建纯色图片
    class func createImage(color:UIColor, size:CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 根据固定的size改变图片大小
    func changeImage(size:CGSize) -> UIImage? {
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size)
        // 绘制改变大小的图片
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        // 从当前context中创建一个改变大小后的图片
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        // 使当前的context出堆栈
        UIGraphicsEndImageContext()
        // 返回新的改变大小后的图片
        return scaledImage
    }
    
    /// 根据最大边按比例改变图片大小
    func changeImage(maxSide:CGFloat) -> UIImage? {
        var scale:CGFloat = 0
        if self.size.width > self.size.height {//横向图片
            scale = maxSide / self.size.width
        }
        else{//竖向图片
            scale = maxSide / self.size.height
        }
        let size = CGSize(width: self.size.width*scale, height: self.size.height*scale)
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size)
        // 绘制改变大小的图片
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        // 从当前context中创建一个改变大小后的图片
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        // 使当前的context出堆栈
        UIGraphicsEndImageContext()
        // 返回新的改变大小后的图片
        return scaledImage
    }
    
    /// 返回图像的灰度模式
    func grayscaleImage() -> UIImage? {
        let size = self.size
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let context = CGContext.init(data: nil,
                                     width: Int(size.width),
                                     height: Int(size.height),
                                     bitsPerComponent: 8,
                                     bytesPerRow: 0,
                                     space: colorSpace,
                                     bitmapInfo: CGImageByteOrderInfo.orderDefault.rawValue)
        if let cgImage = self.cgImage {
            context?.draw(cgImage, in: rect)
            if let grayscale = context?.makeImage() {
                let image = UIImage.init(cgImage: grayscale)
                return image
            }
            else{
                return nil
            }
        }
        else{
            return nil
        }
    }
    
    /// 返回模糊的图片
    func blurryImage(value:CGFloat) -> UIImage {
        
        //获取原始图片
        let inputImage =  CIImage(image: self)
        //使用高斯模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(value, forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: self.size)
        let cgImage = CIContext(options: nil).createCGImage(outputCIImage, from: rect)
        //显示生成的模糊图片
        return UIImage(cgImage: cgImage!)
    }
}
