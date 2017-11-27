//
//  FolderListViewModel.swift
//  Rental
//
//  Created by 吴述军 on 13/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import Foundation
import Photos

class FolderListViewModel {
    
    
    //相簿列表项集合
    var items:[FolderModel] = []
    
    func getFolderList() {
        // 列出所有系统的智能相册
        let fetchOptions = PHFetchOptions()
        let fetchAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: fetchOptions)
        
        self.convertCollection(collection: fetchAlbums)
        
        // 列出所有相册
        let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        self.convertCollection(collection: userCollections as! PHFetchResult<PHAssetCollection>)
        
        //相册按包含的照片数量排序（降序）
        self.items.sort { (item1, item2) -> Bool in
            return item1.fetchResult.count > item2.fetchResult.count
        }
    }
    
    // 转化处理获取到的相簿
    private func convertCollection(collection: PHFetchResult<PHAssetCollection>) {
        
        for i in 0..<collection.count {
            
            //获取出当前相簿内的图片
            let resultsOptions = PHFetchOptions()
            resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                               ascending: false)]
            resultsOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                   PHAssetMediaType.image.rawValue)
            let c = collection[i]
            
            let assetsFetchResult = PHAsset.fetchAssets(in: c, options: resultsOptions)
            //没有图片的空相簿不显示
            if assetsFetchResult.count > 0 {
                items.append(FolderModel(title: c.localizedTitle, fetchResult: assetsFetchResult as! PHFetchResult<PHAssetCollection>))
            }
        }
        
    }

}
