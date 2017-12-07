//
//  MyTopicViewModel.swift
//  Rental
//
//  Created by brant on 2017/9/12.
//  Copyright © 2017年 Brant. All rights reserved.
//

import Foundation
import AVOSCloud
import RxSwift

class MyStrategyViewModel: BaseViewModel {
    
    var topicList: [TopicModel] = []

    // 读取攻略列表
    func queryTopicList() -> Observable<[TopicModel]> {
        
        return Observable.create({ (observer) -> Disposable in
            
            let query = TopicModel.query()
            query.includeKey("items")
            query.findObjectsInBackground { (array, error) in
                if error == nil {
                    guard let data = array else {
                        observer.onNext([])
                        observer.onCompleted()
                        return
                    }
                    
                    self.topicList = data as! [TopicModel]
                    observer.onNext(self.topicList)
                    
                    
                }
                else {
                    observer.onNext([])
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        })
        
    }
}
