//
//  MainTabBarController.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

// MARK: - 主切换控制器
class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildVCs()
    }
    
    private func setupChildVCs() {
        // 回话
        let messageStoreBoard = UIStoryboard.init(name: "Message", bundle: nil)
        let messageVC = messageStoreBoard.instantiateViewController(withIdentifier: "MessageViewController")
        addChildVC(childVC: messageVC, childTitle: "消息", imageName: "", selectedImageName: "")
        
        // 联系人
        let usersListVC = EaseUsersListViewController()
        usersListVC.showSearchBar = true
//        let contactStoreBoard = UIStoryboard.init(name: "Contact", bundle: nil)
//        let contactVC = contactStoreBoard.instantiateViewController(withIdentifier: "ContactViewController")
        addChildVC(childVC: usersListVC, childTitle: "联系人", imageName: "", selectedImageName: "")
        
        // 我的
        let mineStoreBoard = UIStoryboard.init(name: "Mine", bundle: nil)
        let mineVC = mineStoreBoard.instantiateViewController(withIdentifier: "MineViewController")
        addChildVC(childVC: mineVC, childTitle: "我的", imageName: "", selectedImageName: "")
        
    }

    /// 添加子控制器
    private func addChildVC(childVC: UIViewController, childTitle: String, imageName: String, selectedImageName:String)
    {
        let navigation = MainNavigationViewController(rootViewController: childVC)
        //navigation.navigationBar.tintColor = UIColor.black //item 字体颜色
        navigation.navigationBar.barTintColor = UIColor.white //背景颜色
        
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)]
        //标题颜色
        navigation.navigationBar.titleTextAttributes = textAttributes
        childVC.title = childTitle
        childVC.tabBarItem.tag = 1
        //childVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        //childVC.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(navigation)
    }

}
