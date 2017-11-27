//
//  ImageDetailViewController.swift
//  Rental
//
//  Created by 吴述军 on 13/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import UIKit
import Photos
import RxSwift

/*
 * 图片详情页面
 *
 *  功能 ：
 *  1、做图片的裁剪
 *  2、选定图片
 */
class ImageDetailViewController: UIViewController {
    
    var imagePicker: ImagePicker?
    var imageAsset: PHAsset!
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.scalableImageView)
        
        if imagePicker!.isEditable {
            
            self.view.addSubview(self.clipView)
            self.clipView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.width / CGFloat(self.imagePicker!.clipRate))
            self.clipView.centerY = self.view.height / 2.0
        }
        
        // 获取原图
        PHImageManager.default().requestImage(for: imageAsset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: nil) { (image, _: [AnyHashable : Any]?) in
            self.scalableImageView.image = image
            self.image = image
        }
        
        createNavigationItems()
    }
    
    // 初始化导航栏按钮
    func createNavigationItems() {
        let saveItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.done, target: self, action: #selector(createTopic))
        self.navigationItem.rightBarButtonItem = saveItem
    }
    
    
    @objc func createTopic() {
        
        if imagePicker!.isEditable {
            
            if !self.checkPictureSize() {
                print("请调整图片大小")
                return
            }
            
            self.imagePicker?.result.onNext(self.image?.clip(rect: self.getClipRect()))
            self.imagePicker?.result.onCompleted()
            
        }
        else {
            self.imagePicker?.result.onNext(self.image)
            self.imagePicker?.result.onCompleted()
        }

    }
    
    func checkPictureSize() -> Bool {
        if (self.scalableImageView.imageView.x > 0) {
            // 请对图片进行缩放或者更换图片
            return false
        }
        else if (self.scalableImageView.imageView.y > self.clipView.y) {
            // 请对图片进行缩放或者更换图片
            return false
        }
        
        return true
    }
    
    // 计算裁剪的位置
    func getClipRect() -> CGRect {
        guard let originImage = self.image else {
            return CGRect.zero
        }
        
        let rate = (originImage.size.width / self.scalableImageView.imageView.width)
        let offset = self.scalableImageView.contentOffset
        
        if self.scalableImageView.imageView.y > 0 {
            return CGRect(x: offset.x * rate, y: (self.clipView.y - self.scalableImageView.imageView.y) * rate, width: self.clipView.width * rate, height: self.clipView.height * rate)
        }
        else {
            return CGRect(x: offset.x * rate, y: (offset.y + self.clipView.y - self.scalableImageView.y) * rate, width: self.clipView.width * rate, height: self.clipView.height * rate)
        }
        
    }

    private lazy var scalableImageView: ScalableImageView = {
        let imageView = ScalableImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height - 64)) // self.view.bounds)
        return imageView
    }()
    
    private lazy var clipView: ClipView = {
        let view = ClipView()
        view.backgroundColor = UIColor.init(red: 0xf5/255.0, green: 0xf5/255.0, blue: 0xf5/255.0, alpha: 0)
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.red.cgColor
        view.view = self.scalableImageView
        return view
    }()

}
