//
//  TopicSelectViewModel.swift
//  HouseHold
//
//  Created by brant on 2017/11/29.
//  Copyright © 2017年 brant. All rights reserved.
//

import UIKit
import AVOSCloud
import RxSwift

class TopicSelectViewModel: BaseViewModel {

    var topicList: [Topic] = []
    
    func queryTopicList() -> Observable<[Topic]> {
        
        return Observable<[Topic]>.create { (observer) -> Disposable in
            
            let query = Topic.query()
            query.findObjectsInBackground { (results, error) in
                guard let array = results else {
                    
                    observer.onCompleted()
                    
                    return
                }
                
                self.topicList.append(contentsOf: array as! [Topic])
                
                observer.onNext(self.topicList)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
        
    }
}
