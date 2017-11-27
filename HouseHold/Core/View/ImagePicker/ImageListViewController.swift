//
//  ImageListViewController.swift
//  Rental
//
//  Created by 吴述军 on 13/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import UIKit
import Photos

class ImageListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var imagePicker: ImagePicker?
    
    ///取得的资源结果，用了存放的PHAsset
    var assetsFetchResults:PHFetchResult<AnyObject>!
    
    ///缩略图大小
    var assetGridThumbnailSize:CGSize! = CGSize(width: 160, height: 160)
    
    /// 带缓存的图片管理对象
    var imageManager:PHCachingImageManager! = PHCachingImageManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    // MARK: UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier(), for: indexPath) as! ImageCollectionCell
        
        let asset = self.assetsFetchResults[indexPath.row] as! PHAsset
        //获取缩略图
        self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize,
                                               contentMode: PHImageContentMode.aspectFill,
                                               options: nil) { (image, nfo) in
                                                
                                                    cell.imageView.image = image
                                                }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myAsset = self.assetsFetchResults[indexPath.row] as! PHAsset
        
        let vc = ImageDetailViewController()
        vc.imageAsset = myAsset
        vc.imagePicker = self.imagePicker
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    // MARK: lazy load
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        
        ImageCollectionCell.registerForCollectionView(collection: cv)
        
        cv.backgroundColor = UIColor.white
        
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        return layout
    }()

}
