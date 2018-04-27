//
//  Config.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

import Foundation

struct Config {
    
    // 环信的配置文件
    struct RingLetter {
        static let appKey = "1122180425228628#nncb-huanxindemo"
        #if DEBUG
        // 开发环境证书
        static let apnsCertName = "dev_cert"
        #else
        // 生产证书名称
        static let apnsCertName = "production_cert"
        #endif
    }
    
}
