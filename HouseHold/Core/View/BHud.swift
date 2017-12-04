//
//  BHud.swift
//  HouseHold
//
//  Created by 吴述军 on 01/12/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit

class BHud: UIView {
    
    class func hideHud(for view: UIView) {
        view.subviews.forEach { (view) in
            if view is BHud {
                view.removeFromSuperview()
            }
        }
    }

    class func show(in view: UIView) {
        let hud = BHud(frame: view.bounds)
        view.addSubview(hud)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.contentView)
        self.contentView.size = CGSize(width: 50, height: 50)
        self.contentView.centerX = self.width / 2.0
        self.contentView.centerY = self.height / 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var contentView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.purple
        view.layer.cornerRadius = 5.0
        view.layer.masksToBounds = true
        return view
    }()
}
