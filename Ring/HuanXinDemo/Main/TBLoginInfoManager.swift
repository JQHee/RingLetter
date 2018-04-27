//
//  TBLoginInfoManager.swift
//  ThreeBuild
//
//  Created by Apple on 2018/3/12.
//  Copyright © 2018年 广西建工三建. All rights reserved.
//

import UIKit

//// MARK: - 使用方式
extension UserDefaults {
    struct LoginInfo: UserDefaultSettable {
        enum  UserDafaultKey: String {
            case username
            case password
        }
    }
}

class TBLoginInfoManager {
    
    // MARK: - 记住用户名
    static func set(userName: String) {
        UserDefaults.LoginInfo.set(value: userName, forKey: .username)
    }
    
    static func getUserName() -> String {
        guard let userName = UserDefaults.LoginInfo.string(forKey: .username) else {
            return ""
        }
        return userName
    }
    
    // MARK: - 获取密码
    static func set(password: String) {
        UserDefaults.LoginInfo.set(value: password, forKey: .password)
    }
    
    static func getPassword() -> String {
        guard let password = UserDefaults.LoginInfo.string(forKey: .password) else {
            return ""
        }
        return password
    }
    
}
