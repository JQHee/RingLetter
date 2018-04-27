//
//  AppDelegate.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        setupRingLetter()
        setupRootViewController()
        return true
    }
    
}

// MARK: - 环信相关
extension AppDelegate {
    
    // 基本配置
    func setupRingLetter() {
        //AppKey:注册的AppKey
        //apnsCertName:推送证书名（不需要加后缀)
        let options: EMOptions = EMOptions.init(appkey: Config.RingLetter.appKey)
        options.apnsCertName = Config.RingLetter.apnsCertName
        EMClient.shared().initializeSDK(with: options)
        EMClient.shared().add(self, delegateQueue: DispatchQueue.main)
    }
    
    func setupRootViewController() {
        let isAutoLogin = EMClient.shared().isAutoLogin
        if isAutoLogin {
            
            let username = TBLoginInfoManager.getUserName()
            let password = TBLoginInfoManager.getPassword()
            
            // 欢迎页
            let mainStoreBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let welcomeVC = mainStoreBoard.instantiateViewController(withIdentifier: "WelcomeViewController")
            self.window?.rootViewController = welcomeVC
            
            EMClient.shared().login(withUsername: username, password: password) { (str, error) in
                guard let _ = error else { // 没有错误则是登录成功
                    EMClient.shared().options.isAutoLogin = true
                    self.window?.rootViewController = MainTabBarController()
                    self.setupRemoteNotifications()
                    return
                }
                let mainStoreBoard = UIStoryboard.init(name: "Login", bundle: nil)
                let mainVC = mainStoreBoard.instantiateViewController(withIdentifier: "LoginViewController")
                let mainNav = UINavigationController.init(rootViewController: mainVC)
                self.window?.rootViewController = mainNav
            }
            
        } else {
            let mainStoreBoard = UIStoryboard.init(name: "Login", bundle: nil)
            let mainVC = mainStoreBoard.instantiateViewController(withIdentifier: "LoginViewController")
            let mainNav = UINavigationController.init(rootViewController: mainVC)
            self.window?.rootViewController = mainNav
        }
    }
    
    // 登录环信和自动登录
    func loginRingLetter() {
        // 判断是否是自动登录的了
        // 没有登录则去登录
        // 登录成功后，设置自动登录
    }
    
    // 环信的注册
    func registerRingLetter() {
        // 注册方式有两种 开放注册和授权注册
        // 开放注册仅适用开发测试用
        // 授权注册后台服务器做出来，客户端不需要出来
        
    }
    
    // 获取未读信息的数量
    func setupUnReadMessageCount() {
        // 获取所有会话
        let chatManager: IEMChatManager = EMClient.shared().chatManager
        guard let conversations = chatManager.getAllConversations() as?  [EMConversation] else {
            return
        }
        var totalCount: Int32 = 0
        for (_, value) in conversations.enumerated() {
            totalCount += value.unreadMessagesCount
        }
        UIApplication.shared.applicationIconBadgeNumber = Int(totalCount)
    }
    
    
}

// MARK: - EMClientDelegate
extension AppDelegate: EMClientDelegate {
    
    /*!
     *  当前登录账号在其它设备登录时会接收到该回调
     */
    func userAccountDidLoginFromOtherDevice() {
        
    }
}

// MARK: - 推送相关
extension AppDelegate {
    
    // 注册远程推送
    func setupRemoteNotifications() {
        let setting = UIUserNotificationSettings.init(types: [.alert ,.sound , .badge], categories: nil)
        let application = UIApplication.shared
        application.registerUserNotificationSettings(setting)
        
    }
    
    // 上传deviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DispatchQueue.global().async {
            EMClient.shared().bindDeviceToken(deviceToken)
        }
        print("上传deviceToken")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("远程推送注册失败")
    }

    // 本地推送通知
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {

    }

    // ios7及以上系统收到通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        completionHandler(UIBackgroundFetchResult.newData)
    }

    // apns 在ios8系统中，还需要添加这个方法，通过新的api注册推送服务
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
}

// MARK:  - 生命周期相关
extension AppDelegate {
    
    func applicationWillResignActive(_ application: UIApplication) {

    }
    
    // APP进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        setupUnReadMessageCount()
        EMClient.shared().applicationDidEnterBackground(application)
    }
    
    // APP将要从后台返回
    func applicationWillEnterForeground(_ application: UIApplication) {
        EMClient.shared().applicationWillEnterForeground(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

