//
//  HistoryCourseModel.swift
//  WangXiao
//
//  Created by penguin on 2021/6/5.
//

// 历史数据模型
import Foundation

class VideoModel {
    
    /// 视频地址
    var videoUrl:String = ""
    
    /// 标题
    var title:String = ""
    
    
    init(title:String,
         videoUrl:String) {
        self.title = title
        self.videoUrl = videoUrl
    }
}

class HistoryCourseModel {
    
    /// 头像
    var avatarUrl:String = ""
    
    /// 课程名称
    var courseName:String = ""
    
    /// 开始时间
    var startTime:String = ""
    
    /// 结束时间
    var endTime:String = ""
    
    /// 文件id
    var fileId:String = ""
    
    /// 授课人名称
    var nickName:String = ""
    
    /// 视频地址
    var videoUrl:[VideoModel] = []
    
    
    init(avatarUrl:String,
         courseName:String,
         startTime:String,
         endTime:String,
         fileId:String,
         nickName:String,
         videoUrl:[VideoModel]) {
        self.avatarUrl = avatarUrl
        self.courseName = courseName
        self.startTime = startTime
        self.endTime = endTime
        self.fileId = fileId
        self.nickName = nickName
        self.videoUrl = videoUrl
    }
}
