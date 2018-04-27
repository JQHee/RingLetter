//
//  BFUtility.swift
//  Swift_baseFramework
//
//  Created by HJQ on 2018/1/8.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import Foundation

class BFUtility {
    
    /// 延迟执行
    ///
    /// - parameter delay:   延迟时间
    /// - parameter closure: 延迟执行代码
    class func delay(_ delay: Double, closure: @escaping () -> Void) {
        
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
}
