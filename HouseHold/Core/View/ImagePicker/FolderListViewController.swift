//
//  FolderListViewController.swift
//  Rental
//
//  Created by 吴述军 on 13/09/2017.
//  Copyright © 2017 Brant. All rights reserved.
//

import UIKit
import Photos

// 相簿列表
class FolderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imagePicker: ImagePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.getFolderList()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FolderCell.identifier()) as! FolderCell
        
        cell.folderModel = self.viewModel.items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.viewModel.items[indexPath.row]
        
        let vc = ImageListViewController()
        
        //传递相簿内的图片资源
        //if let x = item.fetchResult.firstObject {
            vc.assetsFetchResults = item.fetchResult as! PHFetchResult<AnyObject>
        //}
        vc.imagePicker = self.imagePicker
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private lazy var tableView: UITableView = {
        let tb = UITableView()
        
        FolderCell.registerForTableView(table: tb)
        
        tb.dataSource = self
        tb.delegate = self
        tb.tableFooterView = UIView()
        
        return tb
    }()

    private lazy var viewModel: FolderListViewModel = {
        let vm = FolderListViewModel()
        return vm
    }()
}
