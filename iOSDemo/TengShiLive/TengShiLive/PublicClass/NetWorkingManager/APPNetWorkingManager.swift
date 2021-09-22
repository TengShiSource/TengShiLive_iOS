//
//  APPNetWorkingManager.swift
//
//  Created by penguin on 2019/5/31.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import Alamofire

/// 请求成功回调 （常用的返回字典类型和错误提示语的闭包类型）
typealias NM_SucceedBlock = ([String: Any]) -> Void

/// 请求失败回调 （只带一个error参数的失败闭包类型，主要用于处理失败回调）
typealias NM_FailureErrorBlock = (Error?) -> Void

/// 网络状态(标记是否有网络)
typealias NM_NetworkStatus = (_ isHaveStatus: Bool) -> Void


/// 网络管理
class APPNetWorkingManager {
    
    var request:DataRequest?
    
    deinit {
        if request != nil {
            request?.task?.cancel()
        }
    }
    
    /// 设置通用参数
    private func setting( parameters:inout [String:Any]){
        /// APP 接口版本号
        parameters["app_version"] = APP_VERSION
    }
    /// POST 请求
    ///
    /// - Parameters:
    ///   - URLString: URL地址
    ///   - parameters: 参数
    ///   - success: 成功回调
    ///   - failure: 失败回调
    func POSTRequest(URLString: String,
                     parameters: inout [String:Any],
                     token:String?,
                     success: @escaping NM_SucceedBlock,
                     failure: @escaping NM_FailureErrorBlock) {
        // 暂时没有通用参数
        //setting(parameters: &parameters)
        
        var headers: HTTPHeaders? = nil
        if let temp = token {
            if temp.count>0 {
                headers = ["Authorization": "Bearer "+temp]
            }
        }

        request = AF.request(URLString,
                             method: HTTPMethod.post,
                             parameters: parameters,
                             encoding: JSONEncoding.default,
                             headers: headers){ urlRequest in
            urlRequest.timeoutInterval = 30//超时时间
        }.responseJSON { response in
            //debugPrint(response)
            switch response.result {
            case Result.success:
                
                if let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String : Any] {
                    success(json)
                }
            case Result.failure(let error):
                failure(error)
            }
        }
        
    }
    
    /// GET 请求
    ///
    /// - Parameters:
    ///   - URLString: URL地址
    ///   - parameters: 参数
    ///   - success: 成功回调
    ///   - failure: 失败回调
    func GETRequest<Parameters: Encodable>(URLString: String,
                                           parameters: inout Parameters,
                                           token:String?,
                                           success: @escaping NM_SucceedBlock,
                                           failure: @escaping NM_FailureErrorBlock) {
        
        var headers: HTTPHeaders? = nil
        if let temp = token {
            if temp.count>0 {
                headers = ["Authorization": "Bearer "+temp]
            }
        }
        request = AF.request(URLString,
                             method: HTTPMethod.get,
                             parameters: parameters,
                             encoder: URLEncodedFormParameterEncoder.default,
                             headers: headers) { urlRequest in
            urlRequest.timeoutInterval = 30//超时时间
        }.responseJSON { (response) in
            
            //debugPrint(response)
            switch response.result {
            case Result.success:
                if let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String : Any] {
                    success(json)
                }
            case Result.failure(let error):
                failure(error)
            }
        }
    }
    
    func POSTUpLoadImageRequest(URLString: String,
                                fileName:String,
                                image:UIImage,
                                parameters: inout [String:Any],
                                token:String?,
                                success: @escaping NM_SucceedBlock,
                                failure: @escaping NM_FailureErrorBlock) {
        
        var headers: HTTPHeaders? = nil
        if let temp = token {
            if temp.count>0 {
                headers = ["token": temp]
            }
        }
        AF.upload(multipartFormData: { multipartFormData in
            if let data = image.jpegData(compressionQuality: 1) {
                multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: "jpeg")
            }
        },
        to: URLString, method: .post, headers: headers)
        .responseJSON { response in
            switch response.result {
            case Result.success:
                if let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String : Any] {
                    success(json)
                }
            case Result.failure(let error):
                failure(error)
            }
        }
    }
    
    /// 取消
    func cancelRequest() {
        if request != nil {
            request?.task?.cancel()
        }
    }
    
    /// 开启网络检测
    func beginNetworkMonitoring(networkStatus: @escaping NM_NetworkStatus) {
        let manager = NetworkReachabilityManager(host: "https://www.apple.com/cn")
        manager?.startListening(onUpdatePerforming: {(status) in
            print("当前网络状态: \(status)")
            
            if status == .notReachable {
                networkStatus(false)
            }
            else {
                networkStatus(true)
            }
            manager?.stopListening()
        })
    }
}
