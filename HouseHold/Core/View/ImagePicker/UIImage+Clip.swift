//
//  UIImage+Clip.swift
//  Rental
//
//  Created by 吴述军 on 18/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    // 点击查看详情
    // rect 对应的是图片上的像素
    func clip(rect: CGRect) -> UIImage? {
        
        let subImageRef = self.cgImage?.cropping(to: rect)
        //        let smallBounds = CGRect(x: 0, y: 0, width: subImageRef!.width, height: subImageRef!.height)
        
        //        UIGraphicsBeginImageContext(smallBounds.size)
        //        let context = UIGraphicsGetCurrentContext()
        //        context?.draw(subImageRef!, in: smallBounds)
        let smallImage = UIImage(cgImage: subImageRef!)
        //        UIGraphicsEndImageContext()
        
        return smallImage
        
        
    }
    
    public class func fixOrientation(ofImage image: UIImage) -> UIImage {
        guard image.imageOrientation != .up else {
            return image
        }
        var transform = CGAffineTransform.identity
        switch image.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi/2)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.rotated(by: -CGFloat.pi/2)
            break
        default:
            break
        }
        
        switch image.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: image.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        default:
            break
        }
        
        guard let cgImage = image.cgImage else {
            return image
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        guard let context = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: Int(cgImage.bitsPerComponent), bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return image
        }
        context.concatenate(transform)
        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: image.size.height, height: image.size.width))
            break
        default:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            break
        }
        
        if let cgImg = context.makeImage() {
            return UIImage(cgImage: cgImg)
        }
        
        return image
    }
}
