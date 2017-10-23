//
//  HomeStrategyCell.swift
//  HouseHold
//
//  Created by 吴述军 on 23/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit

class HomeStrategyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var identifier: String {
        get {
            return "HomeStrategyCell"
        }
    }
    
    class func register(for tableView: UITableView) {
        tableView.register(UINib.init(nibName: HomeStrategyCell.identifier, bundle: nil), forCellReuseIdentifier: HomeStrategyCell.identifier)
    }
    
}
