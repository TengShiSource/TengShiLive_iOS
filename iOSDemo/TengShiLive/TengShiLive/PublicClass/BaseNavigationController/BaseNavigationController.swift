//
//  BaseNavigationController.swift
//
//  Created by penguin on 2019/5/27.
//  Copyright © 2019 Penguin. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UINavigationControllerDelegate{
    
    var popDelegate: UIGestureRecognizerDelegate?
    
    override func loadView() {
        super.loadView()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = UIColor.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }
    
    /// 重写push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 1 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.createBackButtonItemBlack(target: self,
                                                                                                        action: #selector(backUpPage))
        }
    }
    
    /// 返回上一页
    @objc func backUpPage(){
        popViewController(animated: true)
    }
    
    // MARK: - UINavigationControllerDelegate方法
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }
        else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }

}
