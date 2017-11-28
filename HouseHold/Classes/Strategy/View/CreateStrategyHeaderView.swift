//
//  CreateStrategyHeaderView.swift
//  HouseHold
//
//  Created by 吴述军 on 06/11/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture
import Kingfisher
import AVOSCloud

class CreateStrategyHeaderView: UIView {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    var strategy: Strategy? {
        didSet {
            
            if let data = strategy?.cover?.getData() {
                self.coverImageView.image = UIImage.init(data: data)
            }
            
            
        }
    }
    
    var coverImageTapGesture: Observable<UITapGestureRecognizer>?
    var titleTapGesture: Observable<UITapGestureRecognizer>?
    var descTapGesture: Observable<UITapGestureRecognizer>?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.coverImageView)
        self.coverImageView.addSubview(imageTipsLabel)
        self.addSubview(titleLabel)
        self.addSubview(separatorView)
        self.addSubview(descLabel)
        
        self.layout()
        
        self.coverImageTapGesture = self.coverImageView.rx.tapGesture().when(.recognized)
        self.titleTapGesture = self.titleLabel.rx.tapGesture().when(.recognized)
        self.descTapGesture = self.descLabel.rx.tapGesture().when(.recognized)
    }
    
    func layout() {
        let rate: CGFloat = 640.0 / 352.0;
        self.coverImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.width / rate)
        
        self.imageTipsLabel.center = self.coverImageView.center
        
        self.titleLabel.frame = CGRect(x: 25, y: self.coverImageView.bottom + 35, width: UIScreen.width - 50, height: 25)
        
        self.separatorView.frame = CGRect(x: 25, y: self.titleLabel.bottom + 40, width: 40, height: 1)
        
        self.descLabel.frame = CGRect(x: 25, y: self.separatorView.bottom + 30, width: UIScreen.width - 50, height: 65)
        
        self.height = self.descLabel.bottom + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    // MARK: - lazy load
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.assistColor
        return imageView
    }()
    
    private lazy var imageTipsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.text = "点击添加图片"
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.assistColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "请输入标题"
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separatorColor
        return view
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.assistColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "请输入描述"
        return label
    }()
}
