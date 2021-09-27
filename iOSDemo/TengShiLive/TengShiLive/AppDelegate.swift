//
//  AppDelegate.swift
//  QMDemo
//
//  Created by penguin on 2021/6/11.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // 后台任务标识
    var backgroundTask:UIBackgroundTaskIdentifier! = nil
    
    func createPush(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // 推送
        let entity = UMessageRegisterEntity()
        //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
        entity.types = Int(UMessageAuthorizationOptions.badge.rawValue |
                            UMessageAuthorizationOptions.alert.rawValue |
                            UMessageAuthorizationOptions.sound.rawValue)
        UNUserNotificationCenter.current().delegate = self
        UMessageSwiftInterface.registerForRemoteNotificationsWithLaunchOptions(launchOptions: launchOptions, entity: entity) { (granted, error) in
            AppPrint(granted)
            AppPrint(error)
        }
    }
    
    //MARK: 配置键盘
    func createKeyboardManager() {
        /// 激活键盘管理
        IQKeyboardManager.shared.enable = true
        // 将右边Done改成完成
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        // 显示占位符开关
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        // 控制是否显示键盘上的工具条
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    //MARK: 应用开始运行
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 键盘管理
        createKeyboardManager()
        createPush(launchOptions: launchOptions)
        
        //FIXME: 同意用户隐私协议后初始化友盟SDK
        APPSingleton.shared.createUM()
        // Bugly
        APPSingleton.shared.createBugly()
        window?.backgroundColor = UIColor.color_Background()
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        
        let result = UMSocialManager.default()?.handleOpen(url)
        if let resultTemp = result {
            print(resultTemp)
            return resultTemp
        }
        else {
            // 其他如支付等SDK的回调
            return false
        }
    }
    
    //MARK: open URL
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        let result = UMSocialManager.default()?.handleOpen(url, options: options)
        if let resultTemp = result {
            print(resultTemp)
            return resultTemp
        }
        else {
            // 其他如支付等SDK的回调
            return false
        }
        
    }
    //MARK: Universal Links
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if (UMSocialManager.default()?.handleUniversalLink(userActivity, options: nil) == true) {
            return true
        }
        
        // Get URL components from the incoming user activity.
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let incomingURL = userActivity.webpageURL,
              let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
            return false
        }
        
        // Check for specific URL components that you need.
        guard let path = components.path,
              let params = components.queryItems else {
            return false
        }
        print("path = \(path)")
        
        if let albumName = params.first(where: { $0.name == "albumname" } )?.value,
           let photoIndex = params.first(where: { $0.name == "index" })?.value {
            
            print("album = \(albumName)")
            print("photoIndex = \(photoIndex)")
            return true
            
        } else {
            print("Either album name or photo index missing")
            return false
        }
    }
    
    //MARK: 当应用程序将要入非活动状态执行，在此期间，应用程序不接收消息或事件，比如来电话了
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state.   This can occur for certain types of temporary interruptions (such as an     incoming phone call or SMS message) or when the user quits the application  and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate  graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    //MARK: 当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // 延迟程序静止的时间
        DispatchQueue.global().async() {
            //如果已存在后台任务，先将其设为完成
            if self.backgroundTask != nil {
                application.endBackgroundTask(self.backgroundTask)
                self.backgroundTask = UIBackgroundTaskIdentifier.invalid
            }
        }
        
        //如果要后台运行
        self.backgroundTask = application.beginBackgroundTask(expirationHandler: {
            () -> Void in
            //如果没有调用endBackgroundTask，时间耗尽时应用程序将被终止
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskIdentifier.invalid
        })
        
    }
    //MARK: 当程序从后台将要重新回到前台时候调用，这个刚好跟上面的那个方法相反
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    //MARK: 当应用程序入活动状态执行，这个刚好跟上面那个方法相反
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    //MARK: 当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: 获取 deviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        UMessageSwiftInterface.registerDeviceToken(deviceToken: deviceToken)
        
        var deviceTokenString = String()
        let bytes = [UInt8](deviceToken)
        for item in bytes {
            deviceTokenString += String(format:"%02x", item&0x000000FF)
        }
        APPSingleton.shared.deviceToken = deviceTokenString
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //      print(error)
    }
    
    //MARK: 静默通知 在前台和后台都是调用
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppPrint(userInfo)
    }
    
    /// 屏幕支持的方向
    public var blockRotation: UIInterfaceOrientationMask = .portrait {
        didSet{
            if blockRotation.contains(.portrait){
                //强制设置成竖屏
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            }else{
                //强制设置成横屏
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            }
        }
    }
    
    //MARK: 设置屏幕支持的方向
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return blockRotation
    }
    
}

//MARK:推送通知 UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // iOS10新增：处理前台收到通知的代理方法
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if let trigger = notification.request.trigger {
            
            let userInfo = notification.request.content.userInfo
            
            if trigger is UNPushNotificationTrigger {
                UMessageSwiftInterface.setAutoAlert(value: true)
                UMessageSwiftInterface.didReceiveRemoteNotification(userInfo: userInfo)
            }
            else {
                //应用处于前台时的本地推送接收
                AppPrint(trigger.classForCoder)
                AppPrint(trigger.self)
            }
        }
        
        //当应用处于前台时提示设置，需要哪个可以设置哪一个
        completionHandler([.badge, .alert, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let trigger = response.notification.request.trigger {
            
            let userInfo = response.notification.request.content.userInfo
            
            if trigger is UNPushNotificationTrigger {
                UMessageSwiftInterface.setAutoAlert(value: true)
                UMessageSwiftInterface.didReceiveRemoteNotification(userInfo: userInfo)
            }
            else {
                //应用处于后台时的本地推送接收
                AppPrint(trigger.classForCoder)
                AppPrint(trigger.self)
            }
        }
    }
}
