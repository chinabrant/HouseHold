//
//  UIImage+House.swift
//  HouseHold
//
//  Created by 吴述军 on 26/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import Foundation

extension UIColor {
    class var backgroundColor: UIColor {
        get {
            return UIColor.init(red: 0xfa/255.0, green: 0xf5/255.0, blue: 0xf5/255.0, alpha: 1)
        }
    }
    
    class var separatorColor: UIColor {
        get {
            return UIColor.init(red: 0xf0/255.0, green: 0xe6/255.0, blue: 0xe6/255.0, alpha: 1)
        }
    }
    
    class var assistColor: UIColor {
        get {
            return UIColor.init(red: 0xaa/255.0, green: 0xa1/255.0, blue: 0xa1/255.0, alpha: 1)
        }
    }
}
