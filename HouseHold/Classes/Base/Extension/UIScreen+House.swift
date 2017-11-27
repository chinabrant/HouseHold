//
//  UIScreen+House.swift
//  HouseHold
//
//  Created by 吴述军 on 06/11/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import Foundation

extension UIScreen {
    class var width: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    
    class var height: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
}
