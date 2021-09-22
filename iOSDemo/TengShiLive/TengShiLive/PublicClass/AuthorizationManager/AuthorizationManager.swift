//
//  AuthorizationManager.swift
//  WangXiao
//
//  Created by penguin on 2021/1/25.
//

import Foundation

import Photos
import AssetsLibrary
import MediaPlayer
import CoreTelephony
import CoreLocation
import AVFoundation

class AuthorizationManager {
    
    /// 1 是否开启媒体资料库/Apple Music 服务
    class func openMediaPlayerServiceWithBlock(action :@escaping ((Bool)->())) {
        let authStatus = MPMediaLibrary.authorizationStatus()
        if authStatus == MPMediaLibraryAuthorizationStatus.notDetermined {
            MPMediaLibrary.requestAuthorization { (status) in
                if (status == MPMediaLibraryAuthorizationStatus.authorized) {
                    DispatchQueue.main.async {
                        action(true)
                    }
                }else{
                    DispatchQueue.main.async {
                        action(false)
                    }
                }
            }
        } else if authStatus == MPMediaLibraryAuthorizationStatus.authorized {
            action(true)
        } else {
            action(false)
        }
    }
    
    /// 2 检测是否开启联网
    class func hw_openEventServiceWithBolck(action :@escaping ((Bool)->())) {
        let cellularData = CTCellularData()
        cellularData.cellularDataRestrictionDidUpdateNotifier = { (state) in
            if state == CTCellularDataRestrictedState.restrictedStateUnknown ||  state == CTCellularDataRestrictedState.notRestricted {
                action(false)
            } else {
                action(true)
            }
        }
        let state = cellularData.restrictedState
        if state == CTCellularDataRestrictedState.restrictedStateUnknown ||  state == CTCellularDataRestrictedState.notRestricted {
            action(false)
        } else {
            action(true)
        }
    }

    /// 3 检测是否开启定位
    class func hw_openLocationServiceWithBlock(action :@escaping ((Bool)->())) {
        var isOpen = false
        if CLLocationManager.locationServicesEnabled() || CLLocationManager.authorizationStatus() != .denied {
            isOpen = true
        }
        action(isOpen)
    }
    
    /// 4 检测是否开启摄像头
    class func hw_openCaptureDeviceServiceWithBlock(action :@escaping ((Bool)->())) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authStatus == AVAuthorizationStatus.notDetermined {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
                action(granted)
            }
        } else if authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied {
            action(false)
        } else {
            action(true)
        }
    }
    /// 5 检测是否开启相册
    class func hw_openAlbumServiceWithBlock(action :@escaping ((Bool)->())) {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        if authStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    action(true)
                } else if status == .denied || status == .restricted{
                    action(false)
                }
            })
        }
        else if authStatus == .restricted || authStatus == .denied {
            action(false)
        }
        else if authStatus == .authorized {
            AppPrint("无权限")
            action(true)
        }
    }

    /// 6 检测是否开启麦克风
    class func hw_openRecordServiceWithBlock(action :@escaping ((Bool)->())) {
        let permissionStatus = AVAudioSession.sharedInstance().recordPermission
        if permissionStatus == AVAudioSession.RecordPermission.undetermined {
            AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
                action(granted)
            }
        } else if permissionStatus == AVAudioSession.RecordPermission.denied {
            action(false)
        } else {
            action(true)
        }
    }
    
    // MARK: - 跳转系统设置界面
    class func hw_OpenURL() {
        let url = URL(string: UIApplication.openSettingsURLString)
        let alertController = UIAlertController(title: "访问受限",
                                                message: "点击“设置”，允许访问权限",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
        let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
            (action) -> Void in
            if  UIApplication.shared.canOpenURL(url!) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url!, options: [:],completionHandler: {(success) in})
                } else {
                    UIApplication.shared.openURL(url!)
                }
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }


}

