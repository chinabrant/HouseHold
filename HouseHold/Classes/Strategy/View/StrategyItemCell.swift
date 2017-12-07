//
//  StrategyItemCell.swift
//  HouseHold
//
//  Created by brant on 2017/12/6.
//  Copyright © 2017年 brant. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class StrategyItemCell: UITableViewCell {
    
    

    var disposeBag: DisposeBag? = DisposeBag()
    
    static var kGap: CGFloat {
        get {
            return 20
        }
    }
    
    class func identifier() -> String {
        return "StrategyItemCell"
    }
    
    class func registerForTableView(table: UITableView) {
        table.register(StrategyItemCell.self, forCellReuseIdentifier: StrategyItemCell.identifier())
    }
    
    // 这里一定要添加，不然不会释放绑定
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 释放绑定
        self.disposeBag = nil
        
        // 复用后，要重新生成
        self.disposeBag = DisposeBag()
    }
    
    var topicItemModel: StrategyItem? {
        didSet {
            self.titleLabel.text = topicItemModel?.title
            self.descLabel.attributedText = topicItemModel?.attributedDesc()
            self.priceLabel.text = "￥\(topicItemModel?.price ?? 0)"
            
            if let urlStr = topicItemModel?.img?.url {
                self.coverImageView.kf.setImage(with: URL(string: urlStr))
            }
            
            // 默认是一个正方形
            var imageHei = UIScreen.width - StrategyItemCell.kGap * 2.0
            if let wid = topicItemModel?.img?.metaData?["width"] as? CGFloat, let hei = topicItemModel?.img?.metaData?["height"] as? CGFloat  {
                
                imageHei = imageHei / (wid / hei)
                // TODO: 这里可能要做一个最大高度的限制
                
            }
            
            // 更新图片的高度约束
            self.coverImageView.snp.updateConstraints { (make) in
                make.height.equalTo(imageHei)
            }
            
            self.setNeedsUpdateConstraints()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.contentView.addSubview(self.coverImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descLabel)
        self.contentView.addSubview(self.priceLabel)
        self.contentView.addSubview(self.goodsDetailButton)
        
        self.layout()
        
        
    }
    
    // 添加 autolayout 约束
    func layout() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(StrategyItemCell.kGap)
            make.top.equalTo(self.contentView.snp.top).offset(StrategyItemCell.kGap)
            make.right.equalTo(self.contentView.snp.right).offset(-StrategyItemCell.kGap)
            //            make.height.equalTo(16)
        }
        
        self.descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(StrategyItemCell.kGap)
            make.right.equalTo(-StrategyItemCell.kGap)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(StrategyItemCell.kGap)
        }
        
        let hei = (UIScreen.main.bounds.size.width - 20) / HomeStrategyCell.StrategyCoverRate
        self.coverImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(StrategyItemCell.kGap)
            make.right.equalTo(self.contentView.snp.right).offset(-StrategyItemCell.kGap)
            make.top.equalTo(self.descLabel.snp.bottom).offset(StrategyItemCell.kGap)
            make.height.equalTo(hei)
        }
        
        self.priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.coverImageView)
            make.centerY.equalTo(self.goodsDetailButton.snp.centerY)
            make.right.equalTo(-StrategyItemCell.kGap)
        }
        
        self.goodsDetailButton.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.right.equalTo(-StrategyItemCell.kGap)
            make.top.equalTo(self.coverImageView.snp.bottom).offset(StrategyItemCell.kGap)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-StrategyItemCell.kGap)
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
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.mainColor
        
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.width - 2 * StrategyItemCell.kGap
        label.textColor = UIColor.mainColor
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.main
        return label
    }()
    
    lazy var goodsDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("查看详情", for: UIControlState.normal)
        button.setTitleColor(UIColor.main, for: UIControlState.normal)
        button.layer.cornerRadius = 4.0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.main.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return button
    }()
}
