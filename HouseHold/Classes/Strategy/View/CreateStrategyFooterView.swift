//
//  CreateStrategyFooterView.swift
//  HouseHold
//
//  Created by 吴述军 on 02/12/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit

class CreateStrategyFooterView: UIView {


    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 84))
        
        self.addSubview(self.addButton)
        self.addButton.y = 10
        self.addButton.centerX = self.width/2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: lazy load
    lazy var addButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "add_164"), for: UIControlState.normal)
        btn.sizeToFit()
        
        return btn
    }()

}
