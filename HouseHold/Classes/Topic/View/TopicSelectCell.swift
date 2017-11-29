//
//  TopicSelectCell.swift
//  HouseHold
//
//  Created by brant on 2017/11/29.
//  Copyright © 2017年 brant. All rights reserved.
//

import UIKit

class TopicSelectCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class var identifier: String {
        get {
            return "TopicSelectCell"
        }
    }
    
    class func register(for tableView: UITableView) {
        tableView.register(UINib.init(nibName: "TopicSelectCell", bundle: nil), forCellReuseIdentifier: TopicSelectCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var topic: Topic? {
        didSet {
            self.titleLabel.text = topic?.title
        }
    }
}
