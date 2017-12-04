//
//  CreateStrategyItemViewModel.swift
//  HouseHold
//
//  Created by 吴述军 on 02/12/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import RxSwift

class CreateStrategyItemViewModel: BaseViewModel {

    var strategyItem: StrategyItem? = StrategyItem()
    
    func saveStrategyItem() -> Observable<(result: Bool, error: Error?)> {
        
        return Observable<(result: Bool, error: Error?)>.create { (observer) -> Disposable in
            self.strategyItem?.saveInBackground({ (isSuccess, error) in
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
}
