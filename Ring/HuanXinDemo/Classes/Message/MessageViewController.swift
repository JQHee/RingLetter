//
//  MessageViewController.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

// MARK: - 会话
class MessageViewController: EaseConversationListViewController {

    
    // MARK: - Lift cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 不能及时刷新
        self.refreshAndSortView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 打开下拉刷新
        self.tableViewDidTriggerHeaderRefresh()
        self.showRefreshHeader = true
        setupUnReadMessageCount()
    }
    
    // MARK: - Private methods
    // 获取未读信息的数量
    private func setupUnReadMessageCount() {
        // 获取所有会话
        UIApplication.sharedDelegate().setupUnReadMessageCount()
    }

}

extension MessageViewController {
    
    
    // 消息来的时候刷新
    override func messagesDidReceive(_ aMessages: [Any]!) {
        self.refreshAndSortView()
        self.setupUnReadMessageCount()
    }
    
    override func messagesDidRead(_ aMessages: [Any]!) {
        self.setupUnReadMessageCount()
    }
}



