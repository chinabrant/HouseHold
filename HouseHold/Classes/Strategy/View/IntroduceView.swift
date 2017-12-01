//
//  IntroduceView.swift
//  HouseHold
//
//  Created by brant on 2017/11/29.
//  Copyright © 2017年 brant. All rights reserved.
//

import UIKit


/// 列表显示的一句话描述
class IntroduceView: UIView {
    
    var subtitle: String? {
        didSet {
            if let title = subtitle {
                self.label.text = title
            }
            else {
                self.label.text = "请输入一句话描述（在首页列表显示）"
            }
            
            
            self.updateFrame()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.label)
        self.label.frame = CGRect(x: 10, y: 10, width: self.width - 20, height: self.height - 20)
    }
    
    func updateFrame() {
        self.label.width = self.width - 20
        self.label.sizeToFit()
        if self.label.height < 22 {
            self.label.height = 22
        }
        
        self.height = self.label.bottom + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: lazy load
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "请输入一句话描述（在首页列表显示）"
        label.textColor = UIColor.assistColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

}
