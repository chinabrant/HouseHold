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
            
            if let title = strategy?.title {
                self.titleLabel.text = title
            }
            else {
                self.titleLabel.text = "请输入标题"
            }
            
            self.topicBackView.title = strategy?.topic?.title
            
            self.descLabel.attributedText = strategy?.attributedDesc()
            
            self.titleLabel.width = UIScreen.width - 50
            self.descLabel.width = UIScreen.width - 50
            
            self.titleLabel.sizeToFit()
            self.descLabel.sizeToFit()
            
            self.updateLayout()
        }
    }
    
    var coverImageTapGesture: Observable<UITapGestureRecognizer>?
    var titleTapGesture: Observable<UITapGestureRecognizer>?
    var descTapGesture: Observable<UITapGestureRecognizer>?
    var topicTapGesture: Observable<UITapGestureRecognizer>?
    var layoutUpdatedSubject: PublishSubject<CGFloat> = PublishSubject<CGFloat>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.coverImageView)
        self.coverImageView.addSubview(imageTipsLabel)
        self.addSubview(titleLabel)
        self.addSubview(separatorView)
        self.addSubview(descLabel)
        
        self.addSubview(self.topicBackView)
        
        self.layout()
        
        self.coverImageTapGesture = self.coverImageView.rx.tapGesture().when(.recognized)
        self.titleTapGesture = self.titleLabel.rx.tapGesture().when(.recognized)
        self.descTapGesture = self.descLabel.rx.tapGesture().when(.recognized)
        self.topicTapGesture = self.topicBackView.rx.tapGesture().when(.recognized)
    }
    
    func updateLayout() {
        if self.titleLabel.height < 25 {
            self.titleLabel.height = 25
        }
        
        self.separatorView.y = self.titleLabel.bottom + 40
        self.descLabel.y = self.separatorView.bottom + 30
//        self.topicBackView.y = self.descLabel.bottom + 20
        
        self.height = self.descLabel.bottom + 10
        
        self.layoutUpdatedSubject.onNext(self.height)
    }
    
    func layout() {
        let rate: CGFloat = 640.0 / 352.0;
        self.coverImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.width / rate)
        
        self.imageTipsLabel.center = self.coverImageView.center
        
        self.topicBackView.frame = CGRect(x: 0, y: self.coverImageView.bottom, width: UIScreen.width, height: 44)
        
        self.titleLabel.frame = CGRect(x: 25, y: self.topicBackView.bottom + 35, width: UIScreen.width - 50, height: 25)
        
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
        label.numberOfLines = 0
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
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var topicBackView: TopicView = {
        let view = TopicView(frame:CGRect(x: 0, y: 0, width: self.width - 50, height: 44))
        view.backgroundColor = UIColor.white
        return view
    }()
    
}
