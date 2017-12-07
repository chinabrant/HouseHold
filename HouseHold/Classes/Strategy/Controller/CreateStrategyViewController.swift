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

class CreateStrategyViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "创建攻略"

        self.view.addSubview(self.tableView)
        self.layout()
        
        self.bindActions()
        
        self.setupNavigationItems()
        
//        self.tableView.tableFooterView = self.footerView
    }
    
    func setupNavigationItems() {
        let saveItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveItem
    }
    
    @objc func save() {
        BHud.show(in: self.view)
        self.viewModel.saveStrategy().subscribe(onNext: { (isSuccess: Bool, error) in
            
            BHud.hideHud(for: self.view)
            if isSuccess {
                print("保存成功了")
                // 保存成功后。显示添加攻略项按钮
                self.tableView.tableFooterView = self.footerView
            }
        }, onError: { (error) in
            BHud.hideHud(for: self.view)
            
            }).disposed(by: self.disposeBag)
    }
    
    func queryItems() {
        
        self.viewModel.queryItems().subscribe(onNext: { (array) in
            
            self.tableView.reloadData()
            
        }, onError: { (error) in
            
            
            
            }).disposed(by: self.disposeBag)
        
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
                
            }).disposed(by: self.disposeBag)    // 这个地方的写法有问题的，不能用这个disposeBag, 要用InputView实例里面的那个
            
        }).disposed(by: self.disposeBag)
        
        // 点击了描述
        self.headerView.descTapGesture?.subscribe(onNext: { (tap) in
            
            InputView.showIn(view: self.navigationController!.view, type: .multi).subscribe(onNext: { (result) in
                
                self.viewModel.strategy?.desc = result
                self.headerView.strategy = self.viewModel.strategy
                
            }).disposed(by: self.disposeBag)
            
        }).disposed(by: self.disposeBag)
        
        // 点击了选择栏目
        self.headerView.topicTapGesture?.subscribe(onNext: { (tap) in
            
            let topicSelectVC = TopicSelectViewController()
            topicSelectVC.result.subscribe(onNext: { (topic) in
                
                // 栏目选择好了
                self.viewModel.strategy?.topic = topic
                self.headerView.strategy = self.viewModel.strategy
                
            }).disposed(by: topicSelectVC.disposeBag)
            
            self.navigationController?.pushViewController(topicSelectVC, animated: true)
            
        }).disposed(by: self.disposeBag)
        
        // 点击了一句话介绍
        self.headerView.introduceTapGesture?.subscribe(onNext: { (tap) in
            
            InputView.showIn(view: self.navigationController!.view, type: .single).subscribe(onNext: { (result) in
                
                self.viewModel.strategy?.subtitle = result
                self.headerView.strategy = self.viewModel.strategy
                
            }).disposed(by: self.disposeBag)
            
        }).disposed(by: self.disposeBag)
        
        // 更新头部的高度
        self.headerView.layoutUpdatedSubject.subscribe(onNext: { (height) in
            
            self.tableView.tableHeaderView = self.headerView
            
        }).disposed(by: self.disposeBag)

        // 点击了添加攻略项
        self.footerView.addButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
        
            let itemVc = UIStoryboard(name: "Strategy", bundle: nil).instantiateViewController(withIdentifier: "CreateStrategyItemViewController") as! CreateStrategyItemViewController
            itemVc.strategy = self.viewModel.strategy
            itemVc.dismissBlock = { (isSuccess) in
                self.queryItems()
            }
            
            self.navigationController?.pushViewController(itemVc, animated: true)
            
        }).disposed(by: self.disposeBag)
    }
    
    func layout() {
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
        
        self.tableView.tableHeaderView = self.headerView
    }
    
    
    // MARK: UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.viewModel.items!.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StrategyItemCell.identifier()) as! StrategyItemCell
        
        let item = self.viewModel.items![indexPath.row]
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
        
        let model = self.viewModel.items![indexPath.row]
        
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
    

    // MARK: - lazy load
    private lazy var headerView: CreateStrategyHeaderView = {
        let header = CreateStrategyHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 0))
        
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        
        StrategyItemCell.registerForTableView(table: table)
        
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.dataSource = self
        table.delegate = self
        
        table.tableFooterView = UIView()
        table.backgroundColor = UIColor.backgroundColor
        return table
    }()
    
    lazy var viewModel: CreateStrategyViewModel = {
        let vm = CreateStrategyViewModel()
        return vm
    }()
    
    private lazy var footerView: CreateStrategyFooterView = {
        let footer = CreateStrategyFooterView()
        
        return footer
    }()
}
