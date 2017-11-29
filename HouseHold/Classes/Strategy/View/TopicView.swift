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
    
    var title: String? {
        didSet {
            if let t = self.title {
                self.topicLabel.text = t
            }
            else {
                self.topicLabel.text = "请选择栏目"
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        
        self.addSubview(self.topicLabel)
        self.addSubview(self.arrowImageView)
        self.addSubview(self.line)
        
        self.topicLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(10)
            maker.top.bottom.equalTo(self)
            maker.right.equalTo(self.arrowImageView.snp.left).offset(-10)
        }
        
        self.arrowImageView.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right).offset(-10)
            maker.centerY.equalTo(self)
        }
        
        self.line.snp.makeConstraints { (maker) in
            maker.left.bottom.right.equalTo(self)
            maker.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = UIColor.gray
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = UIColor.white
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

    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separatorColor
        return view
    }()
}
