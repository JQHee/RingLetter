//
//  ContactViewController.swift
//  HuanXinDemo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

// MARK: - 联系人
class ContactViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableViewData = [[ContactModel]]()
    var buddyList = [String]()
    
    // MARK: - Lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setupTableView()
        setupData()
        // 从服务去上获取好友
        EMClient.shared().contactManager.getContactsFromServer { (buddyList, error) in
            // buddyList 只返回用户名
            guard let buddyList = buddyList else {
                return
            }
            guard let tempBuddyList = buddyList as? [String] else {
                self.loadBuddyListFromServer()
                return
            }
            self.set(buddyList: tempBuddyList)
            if buddyList.isEmpty {
                self.loadBuddyListFromServer()
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessageCellID")
        tableView.tableFooterView = UIView()
    }
    
    private func setupData() {
        let model1 = ContactModel.model(icon: "", title: "验证消息") {
            
        }
        
        let model2 = ContactModel.model(icon: "", title: "群组") {
            
        }
        
        let model3 = ContactModel.model(icon: "", title: "黑名单") {
            
        }
        self.tableViewData.insert([model1, model2, model3], at: 0)
    }
    
    // 从服务器上获取好友列表
    private func loadBuddyListFromServer() {
        EMClient.shared().contactManager.getContactsFromServer { (buddyList, error) in
            guard let buddyList = buddyList else {
                return
            }
            guard let tempBuddyList = buddyList as? [String] else {
                return
            }
            self.set(buddyList: tempBuddyList)
            self.tableView.reloadData()
        }
    }
    
    // 联系人列表
    private func set(buddyList: [String]) {
        self.buddyList = buddyList
        var subArray = [ContactModel]()
        for (_, value) in buddyList.enumerated() {
            let model = ContactModel.model(icon: "", title: value, didBlock: nil)
            subArray.append(model)
        }
        if self.tableViewData.count > 0 {
          self.tableViewData.insert(subArray, at: 1)
        }
    }

}
// MARK: - UITableViewDelegate
extension ContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let arr = self.tableViewData[indexPath.section]
        let data = arr[indexPath.row]
        if let _ = data.didBlock { // 验证消息 群组 黑名单
            data.didBlock!()
            return
        }
        
        // 单聊
        let easeMessageVC = EaseMessageViewController.init(conversationChatter: data.title, conversationType: EMConversationTypeChat)
        easeMessageVC?.title = data.title
        easeMessageVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(easeMessageVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - UITableViewDataSource
extension ContactViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? =  tableView.dequeueReusableCell(withIdentifier: "MessageCellID")
        if let _ = cell {
        } else {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "MessageCellID")
        }
        let arr = self.tableViewData[indexPath.section]
        let data = arr[indexPath.row]
         cell?.textLabel?.text = data.title
        return cell!
    }
}
