//
//  CreateStrategyViewController.swift
//  HouseHold
//
//  Created by 吴述军 on 06/11/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import SnapKit
import AVOSCloud

class CreateStrategyViewController: BaseViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "创建攻略"

        self.view.addSubview(self.tableView)
        self.layout()
        
        self.bindActions()
    }
    
    func bindActions() {
        self.headerView.coverImageTapGesture?.subscribe(onNext: { (tap) in
            
            let imagePicker: ImagePicker = ImagePicker()
            imagePicker.push(with: self)
            imagePicker.isEditable = true
            imagePicker.result.subscribe(onNext: { (img) in
                
                guard let image = img else {
                    return
                }
                
                print("图片选择成功")
                
                let file = AVFile.init(data: UIImagePNGRepresentation(image)!)
                self.viewModel.strategy?.cover = file
                self.headerView.strategy = self.viewModel.strategy
                
                self.navigationController?.popToViewController(self, animated: true)
                
            }).disposed(by: self.disposeBag)
            
        }).disposed(by: self.disposeBag)
        
        // 点击了标题
        self.headerView.titleTapGesture?.subscribe(onNext: { (tap) in
            
            InputView.showIn(view: self.navigationController!.view, type: .single).subscribe(onNext: { (result) in
                
                self.viewModel.strategy?.title = result
                self.headerView.strategy = self.viewModel.strategy
                
            }).disposed(by: self.disposeBag)    // 这个地方的写法有问题的，不能用这个disposeBag
            
        }).disposed(by: self.disposeBag)
        
        // 点击了描述
        self.headerView.descTapGesture?.subscribe(onNext: { (tap) in
            
            InputView.showIn(view: self.navigationController!.view, type: .multi).subscribe(onNext: { (result) in
                
                self.viewModel.strategy?.desc = result
                self.headerView.strategy = self.viewModel.strategy
                
            }).disposed(by: self.disposeBag)
            
        }).disposed(by: self.disposeBag)
        
        // 更新头部的高度
        self.headerView.layoutUpdatedSubject.subscribe(onNext: { (height) in
            
            self.tableView.tableHeaderView = self.headerView
            
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
        table.backgroundColor = UIColor.backgroundColor
        return table
    }()
    
    private lazy var viewModel: CreateStrategyViewModel = {
        let vm = CreateStrategyViewModel()
        return vm
    }()
}
