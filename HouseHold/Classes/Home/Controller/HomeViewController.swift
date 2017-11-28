//
//  HomeViewController.swift
//  HouseHold
//
//  Created by 吴述军 on 20/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

/// 
class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
//    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"

        layout()
        
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(create))
        self.navigationItem.rightBarButtonItem = item
        
        self.queryStrategy()
    }
    
    @objc func create() {
        let vc = CreateStrategyViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func queryStrategy() {
        self.viewModel.queryStrategyList().subscribe(onNext: { (list) in
            
            self.tableView.reloadData()
            
        }).disposed(by: self.disposeBag)
    }
    
    func bindViewModel() {
        
    }
    
    func layout() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
    }
    
    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeStrategyCell.identifier) as! HomeStrategyCell
        
        cell.strategy = self.viewModel.strategyList[indexPath.section]
        
        return cell
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.strategyList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    private lazy var tableView: UITableView = {
        let table = UITableView()
        
        HomeStrategyCell.register(for: table)
        
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.clear
        
        
        return table
    }()

    private lazy var viewModel: HomeViewModel = {
        let vm = HomeViewModel()
        
        return vm
    }()
}
