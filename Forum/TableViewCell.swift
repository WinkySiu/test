//
//  TableViewCell.swift
//  Forum
//
//  Created by winky_swl on 7/1/2018.
//  Copyright © 2018年 winky_swl. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    
    func data_init(message: String) {
        self.message.text = message
    }

}
