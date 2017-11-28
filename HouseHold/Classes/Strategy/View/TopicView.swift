//
//  TopicView.swift
//  HouseHold
//
//  Created by 吴述军 on 28/11/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import SnapKit

class TopicView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.topicLabel)
        self.addSubview(self.arrowImageView)
        
        self.topicLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(10)
            maker.top.bottom.equalTo(self)
            maker.right.equalTo(self.arrowImageView.snp.left).offset(-10)
        }
        
        self.arrowImageView.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right).offset(-10)
            maker.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: lazy load
    private lazy var topicLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.assistColor
        label.text = "请选择栏目"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "arrow_right")
        return imageView
    }()

}
