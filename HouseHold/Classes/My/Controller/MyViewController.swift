//
//  MyViewController.swift
//  HouseHold
//
//  Created by 吴述军 on 20/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit

class MyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - lazy load
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        
        
        return tb
    }

}
