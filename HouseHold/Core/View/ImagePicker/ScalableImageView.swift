//
//  ScalableImageView.swift
//  Rental
//
//  Created by 吴述军 on 13/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import Foundation

public class ScalableImageView: UIScrollView, UIScrollViewDelegate {
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        
        return imgView
    }()
    
    public var image: UIImage? {
        didSet {
            if let image = image {
                self.imageView.image = image
                self.updateImageViewFrame()
            }
        }
    }
    
    public var imageViewSize: CGSize? {
        get {
            return self.imageView.frame.size
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.delegate = self
        
        self.imageView.frame = self.bounds
        self.addSubview(self.imageView)
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 3.0
        self.zoomScale = 1.0
        
        // 添加单击动作
        let tap = UITapGestureRecognizer(target: self, action: #selector(ScalableImageView.tap(tap:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tap)
        
        // 添加连点动作,放到最大
        let tapTwice = UITapGestureRecognizer(target: self, action: #selector(ScalableImageView.tapTwice(tap:)))
        tapTwice.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapTwice)
    }
    
    @objc func tapTwice(tap: UITapGestureRecognizer) {
        
        self.setZoomScale(self.maximumZoomScale, animated: true)
    }
    
    // 单击，回到初始状态
    @objc func tap(tap: UITapGestureRecognizer) {
        self.setZoomScale(1, animated: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.setZoomScale(scrollView.zoomScale, animated: true)
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // 缩放后设置imageView的中点，使图片始终都保持在中间
        self.updateImageViewCenter()
    }
    
    // 设置好图片后，根据图片的大小更新image view的大小及位置
    func updateImageViewFrame() {
        if self.image == nil {
            return
        }
        
        let imageWidth = self.image!.size.width
        let imageHeight = self.image!.size.height
        let rate = imageHeight / imageWidth
        
        if imageWidth > imageHeight {
            // 是横图
            if imageWidth > self.frame.size.width {
                // 图片比view大
                self.imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.width * rate)
            }
            else {
                self.imageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
            }
            
        }
        else {
            // 是竖图
            if imageHeight > self.frame.size.height {
                // 图片比view大
                self.imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.height / rate, height: self.frame.size.height)
            }
            else {
                self.imageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
            }
            
        }
        
        self.updateImageViewCenter()
    }
    
    func updateImageViewCenter() {
        
        let x = max(self.contentSize.width / 2.0, self.frame.size.width / 2.0)
        let y = max(self.contentSize.height / 2.0, self.frame.size.height / 2.0)
        
        self.imageView.center = CGPoint(x: x, y: y)
    }
}
