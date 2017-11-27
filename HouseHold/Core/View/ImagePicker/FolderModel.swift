//
//  FolderModel.swift
//  Rental
//
//  Created by 吴述军 on 13/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import Foundation
import Photos

struct FolderModel {
    
    var title: String?
    
    var fetchResult: PHFetchResult<PHAssetCollection>
    
    init(title: String?, fetchResult: PHFetchResult<PHAssetCollection>) {
        self.title = title
        self.fetchResult = fetchResult
    }
}
