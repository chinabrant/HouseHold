//
//  UIView+Position.swift
//  Rental
//
//  Created by brant on 2017/9/13.
//  Copyright © 2017年 Brant. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func shadow() {
        
    }
    
    func subView(ofClassName className: String) -> UIView? {
        for subView in self.subviews {
            if String(describing: subView) == className {
                return subView
            }
            
            let resultFound = subView.subView(ofClassName: className)
            if resultFound != nil {
                return resultFound
            }
        }
        
        return nil
    }
    
    // x
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    // y
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    // center x
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    // center y
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    // width
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    // height
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    // origin
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    // size
    public var size: CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    public var right: CGFloat {
        get {
            return self.x + self.width
        }
        
        set {
            self.x = newValue - self.width
        }
    }
    
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        }
        
        set {
            self.y = newValue - self.height
        }
    }
    
}
