//
//  CreateStrategyViewModel.swift
//  HouseHold
//
//  Created by brant on 2017/11/28.
//  Copyright © 2017年 brant. All rights reserved.
//

import UIKit
import AVOSCloud
import RxSwift

enum StrategyModifyType {
    case create // 创建新的攻略
    case update // 修改攻略
}

class CreateStrategyViewModel: BaseViewModel {

    var type: StrategyModifyType = .create  // 默认是创建新的攻略
    var strategy: Strategy? = Strategy()
    var items: [StrategyItem]?
    
    func saveStrategy() -> Observable<(result: Bool, error: Error?)> {
        
        return Observable<(result: Bool, error: Error?)>.create { (observer) -> Disposable in
            self.strategy?.saveInBackground({ (isSuccess, error) in
                if isSuccess {
                    print("保存成功")
                    observer.onNext((true, nil))
                }
                else {
                    print("保存失败")
                    observer.onNext((false, error))
                }
                
                
                observer.onCompleted()
            })
            
            return Disposables.create()
        }
        
        
    }
    
    func queryItems() -> Observable<[StrategyItem]?> {
        
        return Observable<[StrategyItem]?>.create { (observer) -> Disposable in
            
            let query = StrategyItem.query()
            query.whereKey("strategy", equalTo: self.strategy)
            query.findObjectsInBackground({ (array, error) in
                if let arr = array {
                    self.items = arr as! [StrategyItem]
                }
                
                observer.onNext(self.items)
                observer.onCompleted()
            })
            
            return Disposables.create()
        }
        
        
    }
}
