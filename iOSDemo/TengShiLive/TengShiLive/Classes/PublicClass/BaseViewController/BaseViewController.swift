//
//  BaseViewController.swift
//
//  Created by penguin on 2019/5/23.
//  Copyright © 2019 Penguin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    /// 动态获取状态条的高度
    var statusBarHight:CGFloat {
        get {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0.0
            } else {
                 return UIApplication.shared.statusBarFrame.height
            }
        }
    }
    
    /// 动态获取状态条加导航条的高度
    var statusBarAndNavigationBar:CGFloat {
        get {
            var statusBar_h:CGFloat = 0.0
            if #available(iOS 13.0, *) {
                statusBar_h = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0.0
            } else {
                statusBar_h = UIApplication.shared.statusBarFrame.height
            }
            
            let navigationBar_h = navigationController?.navigationBar.frame.height ?? 0.0
            let offset = statusBar_h + navigationBar_h
            return offset
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.color_Background()
        //        if traitCollection.userInterfaceStyle == .dark {
        //
        //        }
        //        else{
        //
        //        }
        
    }
    
    /// 设置导航条是否透明
    /// - Parameters:
    ///   - isTranslucent: 导航是否透明
    func setNavigationBar(isTranslucent:Bool)  {
        if isTranslucent == true {
            // 设置导航栏半透明
            self.navigationController?.navigationBar.isTranslucent = true
            // 设置导航栏背景图片
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            // 设置导航栏阴影图片
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        else {
            // 设置导航栏半透明
            self.navigationController?.navigationBar.isTranslucent = false
            // 设置导航栏背景图片
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            // 设置导航栏阴影图片
            self.navigationController?.navigationBar.shadowImage = nil
        }
    }
    
    
    /// 设置导航条是否透明，和显示隐藏
    /// - Parameters:
    ///   - isTranslucent: 导航是否透明
    ///   - isHiddenNavigationBar: 导航是否隐藏
    ///   - animated: 动画
    func setNavigationBar(isTranslucent:Bool, isHiddenNavigationBar:Bool, animated:Bool)  {
        if isTranslucent == true {
            // 设置导航栏半透明
            self.navigationController?.navigationBar.isTranslucent = true
            // 设置导航栏背景图片
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            // 设置导航栏阴影图片
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        else {
            // 设置导航栏半透明
            self.navigationController?.navigationBar.isTranslucent = false
            // 设置导航栏背景图片
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            // 设置导航栏阴影图片
            self.navigationController?.navigationBar.shadowImage = nil
        }
        self.navigationController?.setNavigationBarHidden(isHiddenNavigationBar, animated: animated)
    }
    
    func navigationTitle(text:String) -> () {
        
        if navigationItem.titleView is UILabel {
            let label:UILabel = navigationItem.titleView as! UILabel
            label.text = text
            label.sizeToFit()
        }
        else{
            let titleLabel:UILabel = UILabel(frame: CGRect.zero)
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor = .black
            titleLabel.text = text
            titleLabel.sizeToFit()
            navigationItem.titleView = titleLabel
        }
    }
    
    func navigationTitle(text:String, color:UIColor) -> () {
        
        if navigationItem.titleView is UILabel {
            let label:UILabel = navigationItem.titleView as! UILabel
            label.text = text
            label.sizeToFit()
        }
        else{
            let titleLabel:UILabel = UILabel(frame: CGRect.zero)
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor = color
            titleLabel.text = text
            titleLabel.sizeToFit()
            navigationItem.titleView = titleLabel
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    var isStatusBarHidden = false {
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
