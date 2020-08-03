//
//  RayCopyAlertView.swift
//  RayKit
//
//  Created by admin on 2020/7/22.
//

import UIKit

class RayCopyAlertView: UIView {

    var title: String
    
    var message: String
    
    var rightText: String
    
    var clickClosure: () -> Void
    
    private lazy var titleLab: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.RaySystemFont(ofSize: 15)
        titleLabel.textColor = RayBlackTextColor333
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var contentLab: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.RaySystemFont(ofSize: 15)
        titleLabel.textColor = RayBlackTextColor333
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(RayMainColor, for: .normal)
        button.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return button
    }()

    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "copyIcon"), for: .normal)
        button.addTarget(self, action: #selector(copyButtonClick), for: .touchUpInside)
        return button
    }()

    init(title: String, message: String, rightText: String, clickClosure: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.rightText = rightText
        self.clickClosure = clickClosure
        
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
        
        // title
        let str1 = NSMutableAttributedString.init(string: "激活码：")
        str1.append(RayAttrStringTool.appendColorStrWithString(str: title, font: 15, color: RayBlackTextColor666))
        titleLab.attributedText = str1
        alertContainerView.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        alertContainerView.addSubview(self.copyButton)
        self.copyButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(40)
            make.centerY.equalTo(self.titleLab)
        }
        
        //内容
        let str2 = NSMutableAttributedString.init(string: "设备编号：")
        str2.append(RayAttrStringTool.appendColorStrWithString(str: title, font:  15, color: RayBlackTextColor666))
        contentLab.attributedText = str2
        alertContainerView.addSubview(contentLab)
        contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.left.right.equalTo(titleLab)
            make.height.equalTo(30)
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
        
        //右按钮
        rightButton.setTitle(rightText, for: .normal)
        alertContainerView.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.top.equalTo(vLineView.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func rightButtonClick() {
        close()
        clickClosure()
    }
    
    @objc func copyButtonClick() {
        
        UIPasteboard.general.string = self.title ?? ""
        RayAlertTool.alertManager.showToast(content: "复制成功")
    }
    
    func show() {
        
        self.layer.add(RayAlertViewAnimationTool.getAlertShowAnimation(), forKey: "alertShowAnimation")
    }
    
    func close() {
        
        self.layer.add(RayAlertViewAnimationTool.getAlertCloseAnimation(), forKey: "alertCloseAnimation")
    }
}
