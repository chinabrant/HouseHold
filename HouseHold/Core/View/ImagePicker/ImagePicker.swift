//
//  ImagePicker.swift
//  Rental
//
//  Created by 吴述军 on 16/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import Foundation
import RxSwift

class ImagePicker {
    
    public let disposeBag: DisposeBag = DisposeBag()
    
    public var isEditable: Bool = false
    
    public var clipRate: Float = 3.0 / 1.6  // 裁剪的宽高比
    
    public lazy var result: PublishSubject<UIImage?> = {
        return PublishSubject<UIImage?>()
    }()
    
    public func push(with viewController: UIViewController) {
        let vc = FolderListViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.imagePicker = self
        
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    init() {
//        result.subscribe(onCompleted: { 
//            
//            
//            
//        }).addDisposableTo(self.disposeBag)
    }
}
