//
//  APPLaunchPageViewController.swift
//
//  Created by penguin on 2019/5/23.
//  Copyright © 2019 Penguin. All rights reserved.
//

import UIKit
import Schedule

/// 启动页
class APPLaunchPageViewController: BaseViewController {
    

    private lazy var bottomView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "启动页背景图"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var topView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "启动页顶部图"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// 倒计时Label
    let timerLabel = UILabel()
    var timerCount = 3
    var task: Task?
    
    deinit {
        task?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.color_Background()

        createUI()
        beginTimer()
        
    }
    
    /// 创建UI
    func createUI(){

        /// 背景图
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 60, left: 20, bottom: 40, right: 20))
        }

        // 倒计时lable
        timerLabel.textColor = color_white
        timerLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1990885956)
        timerLabel.font = UIFont.systemFont(ofSize: 14)
        timerLabel.text = "跳过 \(self.timerCount)s"
        timerLabel.textAlignment = .center
        timerLabel.layer.cornerRadius = 18
        timerLabel.layer.masksToBounds = true
        timerLabel.isUserInteractionEnabled = true
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(statusBarHight+20)
            make.right.equalTo(-25)
            make.width.equalTo(70)
            make.height.equalTo(36)
        }
        timerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToNextPage)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /// 开始计时器
    func beginTimer() {
        if task != nil {
            task?.cancel()
        }
        timerCount = 3
        task = Plan.after(1.second, repeating: 1.second).do {
            
            DispatchQueue.main.async {
                self.timerLabel.text = "跳过 \(self.timerCount)s"
                if self.timerCount <= 1 {
                    self.task?.cancel()
                    self.goToNextPage()
                }
                self.timerCount = self.timerCount-1
            }
        }
    }
    
    @objc func goToNextPage() {
        
        self.timerLabel.isUserInteractionEnabled = false
        self.task?.cancel()
//        // 延迟执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            // 标记是否显示引导页
            if APPSingleton.shared.isFirstLogin == true {
                // 显示到引导页
                APPNavigationManager.replaceToGuidePage()
                APPSingleton.shared.isFirstLogin = false
            }
            else {
                APPNavigationManager.replaceToHomePage()
//                if APPSingleton.shared.token.count > 0 {
//                    APPNavigationManager.replaceToHomePage()
//                }
//                else {
//                    APPNavigationManager.replaceToHomePage()
//                }
            }
            
        }
    }
}
