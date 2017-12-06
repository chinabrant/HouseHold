//
//  TopicDetailViewModel.swift
//  Rental
//
//  Created by brant on 2017/9/12.
//  Copyright © 2017年 Brant. All rights reserved.
//

import AVOSCloud
import RxSwift

class StrategyDetailViewModel: BaseViewModel {
    
    var topicModel: Strategy?

    var items: [StrategyItem] = []
    
    func queryTopicItems() -> Observable<[StrategyItem]> {
        
        return Observable<[StrategyItem]>.create({ (observer) -> Disposable in
            
            let query = StrategyItem.query()
            query.whereKey("strategy", equalTo: self.topicModel!)
            query.findObjectsInBackground { (list, error) in
                if error == nil {
                    self.items = list as! [StrategyItem]
                    observer.onNext(self.items)
                }
                else {
                    observer.onNext(self.items)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        })
        
        
    }
    
    
}
