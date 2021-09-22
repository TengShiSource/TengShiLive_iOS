//
//  TICRenderView.h
//  TIC_Demo_Mac
//
//  Created by kennethmiao on 2019/4/1.
//  Copyright © 2019年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, TICStreamType) {
    TICStreamType_Main,
    TICStreamType_Sub,
};

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
@interface TICRenderView : UIView
#else
#import <Cocoa/Cocoa.h>
@interface TICRenderView : NSView
#endif
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) TICStreamType streamType;
/// 标记是否是自己的视频
@property (nonatomic, assign) BOOL isSelf;
/// 标记是否是老师
@property (nonatomic, assign) BOOL isTeacher;

@end


