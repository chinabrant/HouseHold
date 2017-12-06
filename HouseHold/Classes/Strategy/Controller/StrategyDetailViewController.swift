//
//  TopicDetailViewController.swift
//  Rental
//
//  Created by brant on 2017/9/12.
//  Copyright © 2017年 Brant. All rights reserved.
//

import UIKit
import RxSwift

class StrategyDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let disposeBag = DisposeBag()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "攻略详情"

//        self.createNavigationItems()
        
        setupViews()
        
        self.viewModel.queryTopicItems().subscribe(onNext: { (items) in
            
            self.tableView.reloadData()
            
        }).addDisposableTo(self.disposeBag)
    }

    // 初始化导航栏按钮
    func createNavigationItems() {
        let saveItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveItem
    }
    
  
    @objc func save() {
//        self.viewModel.test()
    }
    
    // layout
    func setupViews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.bottomView)
        
        self.tableView.snp.makeConstraints { (maker) in
            maker.left.top.right.equalTo(self.view)
            maker.bottom.equalTo(self.bottomView.snp.top)
        }
        
        self.bottomView.snp.makeConstraints { (maker) in
            maker.left.bottom.right.equalTo(self.view)
            maker.height.equalTo(50)
        }
        
        self.headerView.topicModel = self.viewModel.topicModel
        self.tableView.tableHeaderView = self.headerView
        
    }
    
    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.viewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StrategyItemCell.identifier()) as! StrategyItemCell
        
        let item = self.viewModel.items[indexPath.row]
        cell.topicItemModel = item
        
        // 点击查看详情
        cell.goodsDetailButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { [weak self] () in
            
            guard let tbid = item.tbid else {
                return
            }
            
            // 打开商品详情
//            let vc = RGoodsDetailViewController()
//            vc.viewModel.tbid = tbid
//            vc.viewModel.topicItem = item
//            self?.navigationController?.pushViewController(vc, animated: true)
            
        }).addDisposableTo(cell.disposeBag!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = self.viewModel.items[indexPath.row]
        
        if model.cellHeight <= 0 {
            // 计算cell的高度并缓存起来
            let cell = tableView.dequeueReusableCell(withIdentifier: StrategyItemCell.identifier()) as! StrategyItemCell
            cell.topicItemModel = model
            model.cellHeight = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height + 0.5
        }
        
        return model.cellHeight
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: lazy load
    private lazy var tableView: UITableView = {
        
        let tb = UITableView()
        
        StrategyItemCell.registerForTableView(table: tb)
        
        tb.separatorStyle = UITableViewCellSeparatorStyle.none
        tb.dataSource = self
        tb.delegate = self
        
        // 去除后面的分隔线
        tb.tableFooterView = UIView()
        
        return tb
        
    }()
    
    
    
    lazy var viewModel: StrategyDetailViewModel = {
        let vm = StrategyDetailViewModel()
        return vm
    }()
    
    private lazy var headerView: StrategyHeaderView = {
        let hv = StrategyHeaderView()
        return hv
    }()

    private lazy var bottomView: StrategyDetailBottomView = {
        let view = StrategyDetailBottomView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 50))
        
        return view
    }()
}
