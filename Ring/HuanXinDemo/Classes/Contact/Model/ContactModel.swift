//
//  ContactModel.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

class ContactModel {

    var icon: String = ""
    var title: String = ""
    var didBlock: (() -> ())?
    
    static func model(icon: String, title: String, didBlock: (() -> ())?) -> ContactModel {
        let model = ContactModel()
        model.icon = icon
        model.title = title
        model.didBlock = didBlock
        return model
    }
    
}
