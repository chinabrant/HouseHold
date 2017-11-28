//
//  InputView.swift
//  HouseHold
//
//  Created by brant on 2017/11/28.
//  Copyright © 2017年 brant. All rights reserved.
//

import UIKit
import SnapKit
import RxKeyboard
import RxSwift

// 输入方式，
enum InputLineType {
    case multi      // 多行
    case single     // 单行
}

class InputView: UIView {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    var lineType: InputLineType = .single   // 默认是单行输入
    
    // 要显示的placeholder
    var placeHolder: String? {
        didSet {
            self.textField.placeholder = placeHolder
        }
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        RxKeyboard.instance.frame
            .drive(onNext: { frame in
                
//                self.inputBackView.y = self.height - frame.size.height - self.inputBackView.height
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.contentView.y = self.height - frame.size.height - self.contentView.height
                })
                
            })
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        
        self.addSubview(self.contentView)
        
        if self.lineType == .single {
            // 单行
            self.contentView.frame = CGRect(x: 0, y: self.height, width: self.width, height: 50)
            self.contentView.addSubview(self.textField)
            self.textField.snp.makeConstraints({ (maker) in
                maker.left.equalTo(self.contentView.snp.left).offset(12)
                maker.top.equalTo(self.contentView.snp.top).offset(10)
                maker.right.equalTo(self.contentView.snp.right).offset(-72)
                maker.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
            })
        }
        else {
            // 多行
            self.contentView.frame = CGRect(x: 0, y: self.height, width: self.width, height: 100)
            self.contentView.addSubview(self.textView)
            self.textView.snp.makeConstraints({ (maker) in
                maker.left.equalTo(self.contentView.snp.left).offset(12)
                maker.top.equalTo(self.contentView.snp.top).offset(10)
                maker.right.equalTo(self.contentView.snp.right).offset(-72)
                maker.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
            })
        }
        
        self.contentView.addSubview(self.submitButton)
        self.submitButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.contentView.snp.top).offset(10)
            maker.right.equalTo(self.contentView.snp.right).offset(-12)
            maker.width.equalTo(50)
            maker.height.equalTo(30)
        }
        
        
        self.contentView.addSubview(self.line)
        self.line.snp.makeConstraints { (maker) in
            maker.left.top.right.equalTo(self.contentView)
            maker.height.equalTo(0.5)
        }
    }
    
    class func showIn(view: UIView, type: InputLineType) {
        let inputView = InputView.init()
        inputView.lineType = type
        
        inputView.setupViews()
        view.addSubview(inputView)
        
        if type == .single {
            
            inputView.textField.becomeFirstResponder()
        }
        else {
            inputView.textView.becomeFirstResponder()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    // MARK: lazy load
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.separatorColor.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        
        let view: UIView = UIView(frame:CGRect(x: 0, y: 0, width: 12, height: 30))
        view.backgroundColor = UIColor.clear
        textField.leftView = view
        textField.leftViewMode = UITextFieldViewMode.always
        
        return textField
    }()
    
    // 上面的分隔线
    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separatorColor
        return view
    }()
    
    // 确定按钮
    private lazy var submitButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("确定", for: UIControlState.normal)
        btn.layer.borderColor = UIColor.separatorColor.cgColor
        btn.layer.borderWidth = 0.5
        btn.layer.cornerRadius = 3
        btn.layer.masksToBounds = true
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        return btn
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.layer.borderColor = UIColor.separatorColor.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 2
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        
        return textView
    }()
}
