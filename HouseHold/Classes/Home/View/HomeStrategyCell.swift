//
//  HomeStrategyCell.swift
//  HouseHold
//
//  Created by 吴述军 on 23/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import Kingfisher
import AVOSCloud

class HomeStrategyCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    var strategy: Strategy? {
        didSet {
            self.titleLabel.text = strategy?.title
            self.subtitleLabel.text = strategy?.subtitle
            
            if let nick = strategy?.user?.object(forKey: "nick") {
                self.nickLabel.text = nick as? String
            }
            
            if let sign = strategy?.user?.object(forKey: "sign") {
                
                self.signLabel.text = sign as? String
            }
            
            if let topicTitle = strategy?.topic?.title {
                self.topicLabel.text = topicTitle
            }
            
            if let url = strategy?.cover?.url {
                
                if let urlRes = URL(string: url) {
                    self.coverImageView.kf.setImage(with: urlRes)
                    
                }
            }
            
            let userAvatar = strategy?.user?.object(forKey: "avatar") as! AVFile
            if let url = userAvatar.url {
                if let urlRes = URL(string: url) {
                    self.avatarImageView.kf.setImage(with: urlRes, placeholder: UIImage.init(named: "default_avatar"))
                    
                    
                }
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var identifier: String {
        get {
            return "HomeStrategyCell"
        }
    }
    
    class func register(for tableView: UITableView) {
        tableView.register(UINib.init(nibName: HomeStrategyCell.identifier, bundle: nil), forCellReuseIdentifier: HomeStrategyCell.identifier)
    }
    
}
