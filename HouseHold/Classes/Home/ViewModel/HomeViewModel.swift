//
//  HomeViewModel.swift
//  HouseHold
//
//  Created by 吴述军 on 24/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import AVOSCloud
import RxSwift

class HomeViewModel: BaseViewModel {
    
    var strategyList: [StrategyModel] = []

    func queryStrategyList() -> Observable<[StrategyModel]> {
        
        return Observable<[StrategyModel]>.create { (observer) -> Disposable in
            
            let query = StrategyModel.query()
            query.includeKey("user.nick")
            query.includeKey("user.sign")
            query.includeKey("topic.title")
            query.findObjectsInBackground { (results, error) in
                guard let array = results else {
                    
                    observer.onCompleted()
                    
                    return
                }
                
                self.strategyList.append(contentsOf: array as! [StrategyModel])
                
//                self.strategyList.forEach({ (model) in
//                    print(model.title)
//                })
                
                observer.onNext(self.strategyList)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
        
        
    }
}
