//
//  MyTopicViewController.swift
//  Rental
//
//  Created by 吴述军 on 11/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyStrategyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的攻略"
        self.view.backgroundColor = UIColor.backgroundColor

        self.setupViews()
        
        self.viewModel.queryTopicList().subscribe(onNext: { (list) in
            
            self.tableView.reloadData()
            
        }, onError: { (error) in
            
            
            
        }) { 
            // completed
        }.addDisposableTo(self.disposeBag)
        
        createNavigationItems()
    }
    
    // 初始化导航栏按钮
    func createNavigationItems() {
        let saveItem = UIBarButtonItem(title: "创建", style: UIBarButtonItemStyle.done, target: self, action: #selector(createTopic))
        self.navigationItem.rightBarButtonItem = saveItem
    }
    
    
    @objc func createTopic() {
//        let vc = CreateTopicViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    // layout
    func setupViews() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.topicList.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyStrategyListCell.identifier()) as! MyStrategyListCell
        
        cell.topicModel = self.viewModel.topicList[indexPath.section]
        
        cell.editButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            
            // 编辑
            let vc = CreateStrategyViewController()
            vc.viewModel.type = .update
            
            // 编辑的时候，要copy一份，不然修改放弃后会改变原来的数据
            let model = self.viewModel.topicList[indexPath.section]
            let m = model.copy() as! Strategy
            
//            vc.viewModel.topicModel = m
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }).addDisposableTo(cell.disposeBag)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let hei = (UIScreen.main.bounds.size.width - 20) / MyStrategyListCell.TopicCoverRate + 36 + 10 + 20 + 50
        return hei
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 查看详情
//        let vc = TopicDetailViewController()
//        vc.viewModel.topicModel = self.viewModel.topicList[indexPath.section]
//
//        vc.viewModel.topicModel = self.viewModel.topicList[indexPath.section]
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    

    private lazy var tableView: UITableView = {
       
        let tb = UITableView()
        tb.backgroundColor = UIColor.mainColor2
        
        MyStrategyListCell.registerForTableView(table: tb)
        
        tb.dataSource = self
        tb.delegate = self
        // 去除分隔线
        tb.separatorStyle = UITableViewCellSeparatorStyle.none
        
        // 去除后面的分隔线
        tb.tableFooterView = UIView()
        
        return tb
        
    }()
    
    private lazy var viewModel: MyStrategyViewModel = {
        let vm = MyStrategyViewModel()
        return vm
    }()
}
