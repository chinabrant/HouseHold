//
//  StrategyItemCell.swift
//  HouseHold
//
//  Created by brant on 2017/12/6.
//  Copyright © 2017年 brant. All rights reserved.
//

import UIKit

class StrategyItemCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    // MARK: - lazy load
    private lazy var titleLabel: UILabel = {
       
        let label = UILabel()
        
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        
        let label = UILabel()
        
        return label
    }()
    
//    private lazy var
}
