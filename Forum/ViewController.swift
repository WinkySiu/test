//
//  ViewController.swift
//  Forum
//
//  Created by winky_swl on 6/1/2018.
//  Copyright © 2018年 winky_swl. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    
    var messageList = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 存取資料
        fetch_data()
        
        // 不顯示 table view 中間的線
        tableView.separatorStyle = .none
        
        // 取消table view cell 的選擇效果
        tableView.allowsSelection = false
    }
    
    func fetch_data(){
        ref = Database.database().reference().child("forum")
        
        ref.observe( .value) { (snapshot) in
            // 檢查資料庫中是否有資料
            if snapshot.childrenCount > 0 {
                
                // 先把 messageList 清空
                self.messageList.removeAll()
                
                // 讀取每一筆資料
                for messages in snapshot.children.allObjects as! [DataSnapshot] {
                    let messageObject = messages.value as? [String: AnyObject]
                    let body = messageObject?["body"] as! String

                    // 把資料存到message中
                    let message = Message(body: body)
                    // 把每一筆message資料加入 messageList 中
                    self.messageList.append(message)
                }
                // 更新table view的資料
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        cell.data_init(message: messageList[indexPath.row].body!)
        
        return cell
    }
    
}

// 設定元件的圓角
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

