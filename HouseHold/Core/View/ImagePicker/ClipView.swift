//
//  ClipView.swift
//  Rental
//
//  Created by 吴述军 on 14/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import UIKit

class ClipView: UIView {
    
    var view: UIView?

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self.view
    }

    
}
