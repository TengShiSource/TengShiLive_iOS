//
//  APPHeadFile.swift
//
//  Created by penguin on 2019/5/28.
//  Copyright © 2019 Penguin. All rights reserved.
//

import UIKit
import Foundation
import SnapKit

/// APP_KEY
let APP_KEY:String = "RMGF2JD1UY"
/// APP_SECRET
let APP_SECRET:String = "8OCFTPB1F7"

//MARK: 通知名称

///网络状态通知
let NOTIFICATION_NETWORK_STATUS:String = "networkStatus"
///修改绑定手机通知
let NOTIFICATION_UPDATE_PHONE_NUMBER:String = "updatePhoneNumber"


//MARK: 项目通用信息

// APP版本号(例如 ： 1.2.3)
// 主版本号（1）：当功能模块有较大的变动，比如增加多个模块或者整体架构发生变化。此版本号由项目决定是否修改。
// 子版本号（2）：当功能有一定的增加或变化，比如增加了对权限控制、增加自定义视图等功能。此版本号由项目决定是否修改。
// 阶段版本号（3）：一般是Bug修复或是一些小的变动，要经常发布修订版，时间间隔不限，修复一个严重的bug即可发布一个修订版。此版本号由项目经理决定是否修改。

let APP_VERSION:String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

//CFBundleVersion(Bundle)
let APP_VERSION_BUNDLE:String = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

//应用注册scheme,在Info.plist定义URL types(每个程序定义的都可能不一样，只要保持一致就行了)
let SCHEME:String = "qmschool"

let iTunes_URL = "itms-apps://itunes.apple.com/app/id1557806757"

let appDelegate = UIApplication.shared.delegate as! AppDelegate

//MARK: 属性列表路径

/// cell 间隔 interval
let SECTIONHEADINTERVAL:CGFloat = 5.0
let SECTIONFOOTINTERVAL:CGFloat = 5.0

//MARK: 短信验证码长度
let SMS_CODE_LENGHT: Int = 4

//MARK: ViewModel中回调（闭包）
/// 结果回调
typealias resultMethod = (_ isSuccess:Bool, _ data:[String:Any]?, _ message:String, _ error:Error?) -> Void


// 服务器地址（正式环境）
// let DEFAULT_URL:String = "https://api.jledu.com/api"

// 服务器地址（开发环境）
 let DEFAULT_URL:String = "http://125.32.43.126:9208/live"

// 服务器地址（测试环境）
// let DEFAULT_URL:String = "http://jledu.f3322.net:10000/api"


//MARK: APP接口
/// 01 获取登陆人信息(GET)
let INTERFACE_GET_USERINFO:String = DEFAULT_URL+"/user/getLoginUser"

/// 02 根据课节id取得课系(GET)
let INTERFACE_STUDENT_COURSE_GET_BY_COURSEID:String = DEFAULT_URL+"/student/course/getByCourseId"

//MARK: APP接口

/// 01 (GET) 根据手机号与验证号获取一个appId,经过Gateway从外部调用
let INTERFACE_getAppId:String = DEFAULT_URL+"/app/getAppId"

/// 02 (POST) 配置直播间公共选项,更新表并更新缓存
let INTERFACE_setGlobalOptions:String = DEFAULT_URL+"/app/setGlobalOptions"

/// 03 (GET) 获取验证码
let INTERFACE_getVerifyCode:String = DEFAULT_URL+"/sms/getVerifyCode"

/// 04 (POST) 创建课 不创建腾讯云直播间，老师或学生进入直播间的时候先判断是否存在，如果不存储在前端调用TX sdk创建直播间，直播间号与后台给的courseId相同
let INTERFACE_createCourse:String = DEFAULT_URL+"/lvbcourse/createCourse"

/// 05 (POST) 进入直播间时调用，注册用户到直播间写表和缓存
let INTERFACE_registUser:String = DEFAULT_URL+"/member/registUser"

/// 05 (POST) 获取APP信息（验证id key）
let INTERFACE_getAppInfo:String = DEFAULT_URL+"/app/getAppInfo"

// 上传文件接口
let INTERFACE_uploadFile:String = DEFAULT_URL+"/upload/file"

// 获取课堂状态
let INTERFACE_getCourseParam:String = DEFAULT_URL+"/lvbcourse/getCourseParam"

// 获取头像列表
let INTERFACE_getAvatarUrlList:String = DEFAULT_URL+"/member/getAvatarUrlList"

// 获取历史课程列表
let INTERFACE_getCourseVideoList:String = DEFAULT_URL+"/member/getCourseVideoList"

/// (POST) 老师进入直播间前将班级内的所有学员信息推送给该接口，写入缓存;用于在课堂内显示未在线的学生；
let INTERFACE_addStudents:String = DEFAULT_URL+"/member/addStudents"

/// print
func AppPrint<T>(_ message:T){
    #if DEBUG
    print(message)
    #endif
}
