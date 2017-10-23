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
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"

        layout()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeStrategyCell.identifier)
        
        return cell!
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 10
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
        table.backgroundColor = UIColor.gray
        
        
        return table
    }()

}
