//
//  MyTopicListCell.swift
//  Rental
//
//  Created by brant on 2017/9/20.
//  Copyright © 2017年 Brant. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

class MyStrategyListCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
        disposeBag = DisposeBag()
    }

    static var TopicCoverRate: CGFloat {
        get {
            return 3.0 / 1.6
        }
    }
    
    class func identifier() -> String {
        return "MyStrategyListCell"
    }
    
    class func registerForTableView(table: UITableView) {
        table.register(MyStrategyListCell.self, forCellReuseIdentifier: MyStrategyListCell.identifier())
    }
    
    var topicModel: TopicModel? {
        didSet {
            self.titleLabel.text = topicModel?.title
            
            if let urlStr = topicModel?.cover?.url {
                if let url = URL(string: urlStr) {
                    self.coverImageView.kf.setImage(with: url)
                }
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.coverImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.bottomView)
        self.bottomView.addSubview(self.editButton)
        
        let hei = (UIScreen.main.bounds.size.width - 20) / HomeStrategyCell.StrategyCoverRate
        
        self.coverImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.height.equalTo(hei)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.top.equalTo(self.coverImageView.snp.bottom).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.height.equalTo(16)
            //            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
        
        self.bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.height.equalTo(50)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
        
        self.editButton.snp.makeConstraints { (make) in
            make.edges.equalTo(self.bottomView)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
       
        button.setTitle("编辑", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.orange
        
        return button
    }()

}
