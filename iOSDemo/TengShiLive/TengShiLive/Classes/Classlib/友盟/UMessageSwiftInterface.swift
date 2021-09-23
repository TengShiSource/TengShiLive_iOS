//
//  UMessageSwiftInterface.swift
//  UMengDemo
//
//  Created by 张军华 on 2017/5/31.
//  Copyright © 2017年 UMeng. All rights reserved.
//

import Foundation
import CoreLocation

/// 友盟推送相关接口
class UMessageSwiftInterface: NSObject {

    //MARK: --required
    
    /// 友盟推送的注册接口
    static func registerForRemoteNotificationsWithLaunchOptions(launchOptions:[UIApplication.LaunchOptionsKey: Any]?,entity:UMessageRegisterEntity,completionHandler:@escaping ((_ granted:Bool,_ error:Error?) -> Void)){
        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity, completionHandler: completionHandler)
    }
    /// 解除RemoteNotification的注册（关闭消息推送，实际调用：[[UIApplication sharedApplication] unregisterForRemoteNotifications]）
    static func unregisterForRemoteNotifications(){
        UMessage.unregisterForRemoteNotifications()
    }
    /// 向友盟注册该设备的deviceToken，便于发送Push消息
    static func registerDeviceToken(deviceToken:Data){
        UMessage.registerDeviceToken(deviceToken)
    }
    /// 应用处于运行时（前台、后台）的消息处理，回传点击数据
    static func didReceiveRemoteNotification(userInfo:[AnyHashable:Any]){
        UMessage.didReceiveRemoteNotification(userInfo)
    }
    
    //MARK: --optional
    
    /// 设置是否允许SDK自动清空角标（默认开启）
    static func setBadgeClear(value:Bool){
        UMessage.setBadgeClear(value)
    }
    /// 设置是否允许SDK当应用在前台运行收到Push时弹出Alert框（默认开启）
    static func setAutoAlert(value:Bool){
        UMessage.setAutoAlert(value)
    }
    
    /// 为某个消息发送点击事件
    static func sendClickReportForRemoteNotification(userInfo:Dictionary<String,Any>){
        UMessage.sendClickReport(forRemoteNotification: userInfo)
    }
    
    
    ///---------------------------------------------------------------------------------------
    /// @name tag (optional)
    ///---------------------------------------------------------------------------------------
    
    /// 获取当前绑定设备上的所有tag(每台设备最多绑定1024个tag)
    static func getTags(handle:(@escaping ((_ responseTags:Set<AnyHashable>?,_ remain:Int,_ error:Error?) -> Void)))
    {
        UMessage.getTags(handle)
    }
    
    /// 绑定一个或多个tag至设备，每台设备最多绑定1024个tag，超过1024个，绑定tag不再成功，可`removeTag`来精简空间
    static func addTag(tag:Any?,response:(@escaping (_ responseObject:Any?,_ remain:Int,_ error:Error?) -> Void)){
        UMessage.addTags(tag as Any, response: response)
    }
    
    /// 删除设备中绑定的一个或多个tag
    static func removeTag(tag:Any,response:(@escaping (_ responseObject:Any?,_ remain:Int,_ error:Error?) -> Void)){
       // UMessage.removeTag(tag, response: response)
        UMessage.deleteTags(tag, response: response)
    }
    
//    static func removeAllTags(response:(@escaping (_ responseObject:Any?,_ remain:Int,_ error:Error?) -> Void)){
//       // UMessage.removeAllTags(response)
//    }
    
    
    ///---------------------------------------------------------------------------------------
    /// @name alias (optional)
    ///---------------------------------------------------------------------------------------
    
    /// 绑定一个别名至设备（含账户，和平台类型）
    static func addAlias(name:String,type:String,response:(@escaping (_ responseObject:Any?,_ error:Error?) -> Void)){
        UMessage.addAlias(name, type: type, response: response)
    }
    
    /// 绑定一个别名至设备（含账户，和平台类型）,并解绑这个别名曾今绑定过的设备
    static func setAlias(name:String,type:String,response:(@escaping (_ responseObject:Any?,_ error:Error?) -> Void)){
        UMessage.setAlias(name, type: type, response: response)
    }
    /// 删除一个设备的别名绑定
    static func removeAlias(name:String,type:String,response:(@escaping (_ responseObject:Any?,_ error:Error?) -> Void)){
        UMessage.removeAlias(name, type: type, response: response)
    }
    
}
