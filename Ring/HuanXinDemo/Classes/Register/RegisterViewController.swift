//
//  RegisterViewController.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

// MARK: - 注册
class RegisterViewController: UIViewController {

    @IBOutlet weak var textFieldAccount: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    // MARK: - Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private method
    private func register() {
        
        let userName = textFieldAccount.text ?? ""
        let password = (textFieldPassword.text ?? "").md5()
        if userName.count < 1 {
            return
        }
        
        if password.count < 1 {
            return
        }
        
        EMClient.shared().register(withUsername: userName, password: password) { (str, error) in
            
            guard let _ = error else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            
        }
    }
    
    // MARK: - Event response
    @IBAction func registerButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        register()
    }
    
}
