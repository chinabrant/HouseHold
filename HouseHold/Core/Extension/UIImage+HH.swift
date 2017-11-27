//
//  UIImage+HH.swift
//  HouseHold
//
//  Created by 吴述军 on 26/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import Foundation

extension UIImage {
    
    class func image(color: UIColor, height: CGFloat) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
