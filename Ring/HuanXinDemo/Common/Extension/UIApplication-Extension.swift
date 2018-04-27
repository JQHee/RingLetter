//
//  UIApplication-Extension.swift
//  Swift_baseFramework
//
//  Created by HJQ on 2018/1/8.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    /**
     UIApplication.sharedApplication().delegate
     
     - returns: AppDelegate
     */
    static func sharedDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /**
     app BundleName
     */
    func appBundleName() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
    func appBundleDispalyName() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    /**
     app BundleIdentifier
     */
    func appBundleID() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
    }
    
    /**
     app BundleShortVersionString
     */
    func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    /**
     app BundleVersion
     */
    func appBuildVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }

}
