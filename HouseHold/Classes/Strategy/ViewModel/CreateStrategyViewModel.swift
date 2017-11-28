//
//  CreateStrategyViewModel.swift
//  HouseHold
//
//  Created by brant on 2017/11/28.
//  Copyright © 2017年 brant. All rights reserved.
//

import UIKit

enum StrategyModifyType {
    case create // 创建新的攻略
    case update // 修改攻略
}

class CreateStrategyViewModel: BaseViewModel {

    var type: StrategyModifyType = .create  // 默认是创建新的攻略
    var strategy: Strategy? = Strategy()
}
