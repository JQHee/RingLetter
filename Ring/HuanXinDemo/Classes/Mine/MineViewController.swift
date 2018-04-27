//
//  MineViewController.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

// MARK: - 我的
class MineViewController: UIViewController {

    @IBOutlet weak var labelUserName: UILabel!
    
    
    // MARK: - Lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelUserName.text = "当前用户：" + EMClient.shared().currentUsername

    }
    
    // MARK: - Event response
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        EMClient.shared().logout(false) { (error) in
            guard let _ = error else {
                UIApplication.sharedDelegate().setupRootViewController()
                return
            }
        }
    }
    


}
