//
//  FolderCell.swift
//  Rental
//
//  Created by 吴述军 on 13/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import UIKit
import SnapKit

class FolderCell: UITableViewCell {
    
    var folderModel: FolderModel? {
        didSet {
            self.titleLabel.text = folderModel?.title
        }
    }
    
    class func identifier() -> String {
        return "FolderCell"
    }
    
    class func registerForTableView(table: UITableView) {
        table.register(FolderCell.self, forCellReuseIdentifier: FolderCell.identifier())
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        self.layout()
    }
    
    func layout() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-40)
            make.centerY.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
