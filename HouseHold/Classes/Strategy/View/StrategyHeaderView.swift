//
//  TopicHeaderView.swift
//  Rental
//
//  Created by brant on 2017/9/12.
//  Copyright © 2017年 Brant. All rights reserved.
//

import UIKit
import Kingfisher

class StrategyHeaderView: UIView {

    init() {
        let coverHeight = UIScreen.main.bounds.size.width / HomeStrategyCell.StrategyCoverRate
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: coverHeight + 20 + 20 + 20))
        
        self.addSubview(self.coverImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.descLabel)
        self.addSubview(self.separator)
//        self.coverImageView.addSubview(self.picTipLabel)
        
    }

    var topicModel: Strategy? {
        didSet {
            let coverHeight = UIScreen.main.bounds.size.width / HomeStrategyCell.StrategyCoverRate
            self.coverImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: coverHeight)
//            self.picTipLabel.center = self.coverImageView.center
            
            if let urlStr = topicModel?.cover?.url {
                
                self.coverImageView.kf.setImage(with: URL(string: urlStr))
            }
            
            self.titleLabel.text = topicModel?.title
            self.titleLabel.frame = CGRect(x: 20, y: self.coverImageView.frame.size.height + 20, width: UIScreen.width - 40, height: 20)
            
            self.separator.frame = CGRect(x: 20, y: self.titleLabel.bottom + 20, width: 60, height: 1)
            
            self.descLabel.frame = CGRect(x: 20, y: self.separator.bottom + 20, width: self.width - 40, height: 1)
//            self.descLabel.text = topicModel?.desc
            self.descLabel.attributedText = topicModel?.attributedDesc()
            self.descLabel.sizeToFit()
            self.descLabel.y = self.separator.bottom + 20
            self.height = self.descLabel.bottom + 20
            
        }
    }
    
    // MARK: lazy load
    private lazy var coverImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.mainColor
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = UIColor.mainColor
        return label;
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separatorColor
        return view
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
