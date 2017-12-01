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
    
    func saveStrategy() -> Observable<(result: Bool, error: Error?)> {
        
        Observable<(result: Bool, error: Error?)>.create { (<#AnyObserver<(result: Bool, error: Error?)>#>) -> Disposable in
            <#code#>
        }
        
        strategy?.saveInBackground({ (isSuccess, error) in
            if isSuccess {
                print("保存成功")
            }
            else {
                print("保存失败")
            }
        })
    }
}
