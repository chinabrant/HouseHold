//
//  TopicSelectViewController.swift
//  HouseHold
//
//  Created by brant on 2017/11/29.
//  Copyright © 2017年 brant. All rights reserved.
//

import UIKit
import RxSwift
import AVOSCloud
import SnapKit

/*
 选择栏目的页面， 在创建攻略修改攻略的时候会用到
 */
class TopicSelectViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    var result: PublishSubject<Topic> = PublishSubject<Topic>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择栏目"

        self.setupViews()
        
        self.viewModel.queryTopicList().subscribe(onNext: { (topicList) in
            
            self.tableView.reloadData()
            
        }, onError: { error in
            
        }).disposed(by: self.disposeBag)
    }
    
    func setupViews() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
    }

    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.topicList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopicSelectCell.identifier) as! TopicSelectCell
        
        cell.topic = self.viewModel.topicList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.result.onNext(self.viewModel.topicList[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: lazy load
    private lazy var tableView: UITableView = {
        let table = UITableView()
        
        TopicSelectCell.register(for: table)
        
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.clear
        table.tableFooterView = UIView()
        
        return table
    }()
    
    private lazy var viewModel: TopicSelectViewModel = {
        let vm = TopicSelectViewModel()
        
        return vm
    }()
}
