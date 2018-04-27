//
//  AddNewContactViewController.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

// 新增联系人
class AddNewContactViewController: UIViewController {

    @IBOutlet weak var textFieldUserName: UITextField!
    
    // MARK: - Lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private methods
    private func addNewContact() {
        let userName = textFieldUserName.text ?? ""
        
        EMClient.shared().contactManager.addContact(userName, message: "我想加您为好友") { (str, error) in
            guard let _ = error else {
                print("添加好友请求发送成功")
                return
            }
        }
        
    }
    
    // MARK: - Event response
    @IBAction func sureButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        addNewContact()
    }
    

}
