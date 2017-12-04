//
//  CreateStrategyItemViewController.swift
//  HouseHold
//
//  Created by 吴述军 on 02/12/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import AVOSCloud

class CreateStrategyItemViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    let disposeBag = DisposeBag()

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tbidTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    var strategy: Strategy? {
        didSet {
            self.viewModel.strategyItem?.strategy = strategy
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "创建攻略项"

        self.titleTextField.delegate = self
        self.tbidTextField.delegate = self
        self.priceTextField.delegate = self
        
        self.setupNavigationItems()
        
        self.bindViewModel()
    }

    func setupNavigationItems() {
        let saveItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveItem
    }
    
    func bindViewModel() {
        
        // 标题改变
        self.titleTextField.rx.text.asObservable().subscribe(onNext: { (string) in
            
            self.viewModel.strategyItem?.title = string
            
        }).disposed(by: self.disposeBag)
        
        // 淘宝id改变
        self.tbidTextField.rx.text.asObservable().subscribe(onNext: { (string) in
            
            self.viewModel.strategyItem?.tbid = string
            
        }).disposed(by: self.disposeBag)
        
        self.descTextView.rx.text.asObservable().subscribe(onNext: { (string) in
            
            self.viewModel.strategyItem?.desc = string
            
        }).disposed(by: self.disposeBag)
        
        self.priceTextField.rx.text.asObservable().subscribe(onNext: { (string) in
            
            if let str = string {
                self.viewModel.strategyItem?.price = Double(str)
            }
            
        }).disposed(by: self.disposeBag)
        
        // 点击了图片
        self.imgView.rx.tapGesture().when(.recognized).subscribe(onNext: { (tap) in
            
            let imagePicker: ImagePicker = ImagePicker()
            imagePicker.push(with: self)
//            imagePicker.isEditable = true
            imagePicker.result.subscribe(onNext: { (img) in
                
                guard let image = img else {
                    return
                }
                
                self.imgView.image = img
                print("图片选择成功")
                
                let file = AVFile.init(data: UIImagePNGRepresentation(image)!)
                self.viewModel.strategyItem?.img = file
//                self.imgView.strategy = self.viewModel.strategy
                
                self.navigationController?.popToViewController(self, animated: true)
                
            }).disposed(by: self.disposeBag)
            
        }).disposed(by: self.disposeBag)
    }
    
    @objc func save() {
        BHud.show(in: self.view)
        self.viewModel.saveStrategyItem().subscribe(onNext: { (isSuccess, error) in
            
            BHud.hideHud(for: self.view)
            if isSuccess {
                print("保存成功了")
            }
            else {
                print("保存失败了")
            }
            
            
        }).disposed(by: self.disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 2
        }
        
        return 1
    }

    // MARK: - UITextField delegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // MARK: - UITextView delegate
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    private var viewModel: CreateStrategyItemViewModel = {
        let vm = CreateStrategyItemViewModel()
        
        return vm
    }()
}
