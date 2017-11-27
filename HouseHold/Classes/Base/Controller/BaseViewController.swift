//
//  BaseViewController.swift
//  HouseHold
//
//  Created by 吴述军 on 20/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
