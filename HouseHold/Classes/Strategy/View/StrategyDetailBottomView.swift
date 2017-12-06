//
//  TopicDetailBottomView.swift
//  Rental
//
//  Created by brant on 2017/10/6.
//  Copyright © 2017年 Brant. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

// 收藏、评论 hei 50
class StrategyDetailBottomView: UIView {
    
    let disposeBag: DisposeBag = DisposeBag()
    var buttonClickSubject: PublishSubject<Int> = PublishSubject<Int>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.layer.shadowColor = UIColor.main.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        
        self.addSubview(self.likeView)
        self.addSubview(self.commentView)
        
        self.likeView.rx.tapGesture().when(.recognized).subscribe(onNext: { (gesture) in
            
            self.buttonClickSubject.onNext(0)
            
        }).addDisposableTo(self.disposeBag)
        
        self.commentView.rx.tapGesture().when(.recognized).subscribe(onNext: { (gesture) in
            
            self.buttonClickSubject.onNext(1)
            
        }).addDisposableTo(self.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var likeView: ItemView = {
        let view = ItemView(frame: CGRect(x: 0, y: 0, width: UIScreen.width / 2.0, height: 50))

        return view
    }()

    private lazy var commentView: ItemView = {
        let view = ItemView(frame: CGRect(x: UIScreen.width / 2.0, y: 0, width: UIScreen.width / 2.0, height: 50))
        
        return view
    }()
}

class ItemView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        
        self.imageView.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        self.imageView.centerY = self.height / 2.0
        self.imageView.centerX = self.width / 2.0 - 10
        self.titleLabel.frame = CGRect(x: self.imageView.right + 5, y: 0, width: self.width - self.imageView.right - 5, height: 20)
        self.titleLabel.centerY = self.height / 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "topic_like")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.assist
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "0"
        return label
    }()
}
