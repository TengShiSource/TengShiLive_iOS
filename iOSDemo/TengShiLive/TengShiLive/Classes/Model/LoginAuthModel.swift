//
//  LoginAuthModel.swift
//  quanzi
//
//  Created by penguin on 2019/10/14.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation

/// 登录授权信息（暂时没用）
class LoginAuthModel {
    /// 参考友盟命名
    // https://developer.umeng.com/docs/128606/detail/129443
    
    
    /// 用户唯一标识：uid能否实现Android与iOS平台打通，目前QQ只能实现同APPID下用户ID匹配
    var uid = ""
    
    /// 用户唯一标识：主要为微信和QQ使用
    var openid = ""
    
    /// 用户唯一标识：主要为微信和QQ使用，unionid主要用于微信、QQ用户系统打通
    var unionid = ""
    
    /// 用户昵称
    var name = ""
    
    /// 用户性别 该字段会直接返回男女
    var gender = ""
    
    /// 用户头像
    var iconurl = ""
    
    init(uid:String,
         openid:String,
         unionid:String,
         name:String,
         gender:String,
         iconurl:String) {
        self.uid = uid
        self.openid = openid
        self.unionid = unionid
        self.name = name
        self.gender = gender
        self.iconurl = iconurl
    }
}
