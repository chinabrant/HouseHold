//
//  CreateStrategyViewController.swift
//  HouseHold
//
//  Created by 吴述军 on 06/11/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import SnapKit

class CreateStrategyViewController: BaseViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.layout()
        
        self.bindActions()
    }
    
    func bindActions() {
        self.headerView.coverImageTapGesture?.subscribe(onNext: { (tap) in
            
            let imagePicker: ImagePicker = ImagePicker()
            imagePicker.push(with: self)
            imagePicker.result.subscribe(onNext: { (image) in
                
                print("图片选择成功")
                
            }).disposed(by: self.disposeBag)
            
        }).disposed(by: self.disposeBag)
    }
    
    func layout() {
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
        
        self.tableView.tableHeaderView = self.headerView
    }

    // MARK: - lazy load
    private lazy var headerView: CreateStrategyHeaderView = {
        let header = CreateStrategyHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 0))
        
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        
        return table
    }()
}
