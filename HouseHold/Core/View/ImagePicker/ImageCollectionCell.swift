//
//  ImageCollectionCell.swift
//  Rental
//
//  Created by 吴述军 on 13/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import UIKit
import SnapKit
import Photos

class ImageCollectionCell: UICollectionViewCell {
    
    class func identifier() -> String {
        return "ImageCollectionCell"
    }
    
    class func registerForCollectionView(collection: UICollectionView) {
        collection.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.identifier())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
}
