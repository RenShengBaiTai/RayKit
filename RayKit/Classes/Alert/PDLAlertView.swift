//
//  PDLAlertView.swift
//  还借钱
//
//  Created by gj on 2017/8/2.
//  Copyright © 2017年 htouhui. All rights reserved.
//

import UIKit

enum PDLAlertType {
    
    case none    // 默认
    case oneType // 只有一个标题
}

class PDLAlertView: UIView {

    var title: String
    
    var message: NSAttributedString
    
    var leftText: String
    
    var rightText: String
    
    var alertType: PDLAlertType
    
    var clickClosure: (_ direction: Bool) -> Void
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.RaySystemFont(ofSize: 19)
        titleLabel.textColor = RayBlackTextColor333
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.clear
        return titleLabel
    }()
    
    private lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont.RaySystemFont(ofSize: 14)
        contentLabel.textColor = RayBlackTextColor666
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center
        contentLabel.backgroundColor = UIColor.clear
        return contentLabel
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(RayBlackTextColor666, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(RayMainColor, for: .normal)
        button.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return button
    }()
    
    init(title: String, message: NSAttributedString, leftText: String, rightText: String, type: PDLAlertType, clickClosure: @escaping (_ direction: Bool) -> Void) {
        
        self.title = title
        self.message = message
        self.leftText = leftText
        self.rightText = rightText
        self.clickClosure = clickClosure
        self.alertType = type
        
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.clear
        frame = UIScreen.main.bounds
        
        setupUI()
    }
    
    private func setupUI() {
        
        let height = 201 / 375 * RayScreenWidth
        
        //弹窗主体
        let alertContainerView = UIView()
        alertContainerView.backgroundColor = UIColor.white
        alertContainerView.layer.cornerRadius = 5
        addSubview(alertContainerView)
        
        alertContainerView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(height)
        }
        
        if self.alertType == .none{
            
            //标题
            titleLabel.text = title
            alertContainerView.addSubview(titleLabel)
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(25)
                make.left.equalToSuperview().offset(30)
                make.right.equalToSuperview().offset(-30)
            }
            
            //内容
            contentLabel.attributedText = message
            alertContainerView.addSubview(contentLabel)
            
            contentLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.left.right.equalTo(titleLabel)
            }
            
        }else {
            
            //标题
            titleLabel.text = title
            alertContainerView.addSubview(titleLabel)
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(60)
                make.left.equalToSuperview().offset(30)
                make.right.equalToSuperview().offset(-30)
            }
        }
        
        
        //按钮上方横线
        let vLineView = UIView()
        vLineView.backgroundColor = UIColor(hexString: "#dddddd")
        alertContainerView.addSubview(vLineView)
        
        vLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview().offset(-52)
        }
        
        //按钮中间的竖线
        let hLineView = UIView()
        hLineView.backgroundColor = UIColor(hexString: "#dddddd")
        alertContainerView.addSubview(hLineView)
        
        hLineView.snp.makeConstraints { (make) in
            make.bottom.centerX.equalToSuperview()
            make.top.equalTo(vLineView.snp.bottom)
            make.width.equalTo(0.5)
        }
        
        //左按钮
        leftButton.setTitle(leftText, for: .normal)
        alertContainerView.addSubview(leftButton)
        
        leftButton.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.right.equalTo(hLineView.snp.left)
            make.top.equalTo(vLineView.snp.bottom)
        }
        
        //右按钮
        rightButton.setTitle(rightText, for: .normal)
        alertContainerView.addSubview(rightButton)
        
        rightButton.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.left.equalTo(hLineView.snp.right)
            make.top.equalTo(vLineView.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func leftButtonClick() {
        close()
        clickClosure(false)
    }
    
    @objc func rightButtonClick() {
        close()
        clickClosure(true)
    }
    
    func show() {
        
        self.layer.add(RayAlertViewAnimationTool.getAlertShowAnimation(), forKey: "alertShowAnimation")
    }
    
    func close() {
        
        self.layer.add(RayAlertViewAnimationTool.getAlertCloseAnimation(), forKey: "alertCloseAnimation")
    }
    
    
    
}
