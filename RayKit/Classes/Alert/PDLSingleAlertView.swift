//
//  PDLSingleAlertView.swift
//  还借钱
//
//  Created by gj on 2017/8/2.
//  Copyright © 2017年 htouhui. All rights reserved.
//

import UIKit
import SnapKit

class PDLSingleAlertView: UIView {

    var title: String
    
    var message: NSAttributedString
    
    var buttonText: String
    
    var clickClosure: () -> Void
    
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
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(RayMainColor, for: .normal)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return button
    }()
    
    init(title: String, message: NSAttributedString, buttonText: String, clickClosure: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.buttonText = buttonText
        self.clickClosure = clickClosure
        
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.clear
        frame = UIScreen.main.bounds
        
        setupUI()
    }
    
    private func setupUI() {
        
        let height = 160 / 375 * RayScreenWidth
        
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
        
        //按钮上方横线
        let vLineView = UIView()
        vLineView.backgroundColor = UIColor(hexString: "#dddddd")
        alertContainerView.addSubview(vLineView)
        
        vLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview().offset(-52)
        }
        
        
        //按钮
        button.setTitle(buttonText, for: .normal)
        alertContainerView.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(vLineView.snp.bottom)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClick() {
        close()
        clickClosure()
    }
    
    func show() {
        
        self.layer.add(RayAlertViewAnimationTool.getAlertShowAnimation(), forKey: "alertShowAnimation")
    }
    
    func close() {
        
        self.layer.add(RayAlertViewAnimationTool.getAlertCloseAnimation(), forKey: "alertCloseAnimation")
    }


}
