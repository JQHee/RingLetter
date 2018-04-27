//
//  LoginViewController.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

// MARK: - 登录
class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldAccount: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    // MARK: - Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private methods
    private func login() {

        let userName = textFieldAccount.text ?? ""
        let password = (textFieldPassword.text ?? "").md5()
        
        if userName.count < 1 {
            return
        }
        
        if password.count < 1 {
            return
        }
                
        EMClient.shared().login(withUsername: userName, password: password) { (str, error) in
            guard let _ = error else {
                // 设置自动登录
                EMClient.shared().options.isAutoLogin = true
                TBLoginInfoManager.set(userName: userName)
                TBLoginInfoManager.set(password: password)
                UIApplication.sharedDelegate().setupRootViewController()
                return
            }
        }
    }
    
    // MAKR: - Event response
    @IBAction func loginButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        login()
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
    }
    

}
