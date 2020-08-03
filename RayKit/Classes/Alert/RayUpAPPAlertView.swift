//
//  RayUPAPPAlertView.swift
//  RayKit
//
//  Created by admin on 2020/7/10.
//

import UIKit

class RayUpAPPAlertView: UIView {

    // 内容
    var message: String
    // 确定
    var rightText: String
    // 是否展示取消按钮
    var isShowCancel: Bool
    
    var clickClosure: (_ direction: Bool) -> Void
    
    private lazy var headView: UIImageView = {
        let headV = UIImageView()
        headV.image = RayImageTool.getBundleImage(imageName: "RayUpAPPHeadImg", bundleName: "RayKit", targetClass: type(of: self))
        return headV
    }()
    
    private lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont.RaySystemFont(ofSize: 14)
        contentLabel.textColor = RayBlackTextColor666
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setImage(RayImageTool.getBundleImage(imageName: "RayCloseButton", bundleName: "RayKit", targetClass: type(of: self)), for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return button
    }()
    
    init(message: String, rightText: String, isShowCancel: Bool, clickClosure: @escaping (_ direction: Bool) -> Void) {
        self.message = message
        self.rightText = rightText
        self.clickClosure = clickClosure
        self.isShowCancel = isShowCancel
        
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.clear
        frame = UIScreen.main.bounds
        
        setupUI()
    }
    
    private func setupUI() {
                
        //弹窗主体
        let alertContainerView = AlertContainerView()
        alertContainerView.backgroundColor = UIColor(hexString: "#629DF7")
        alertContainerView.layer.cornerRadius = 20
        addSubview(alertContainerView)
        alertContainerView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
        
        // 头
        alertContainerView.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
        
        //内容
        let conV: UIView = UIView()
        conV.backgroundColor = RayBackGroudColor
        alertContainerView.addSubview(conV)
        conV.snp.makeConstraints { (make) in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        contentLabel.text = message
        conV.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        //右按钮
        rightButton.setTitle(rightText, for: .normal)
        alertContainerView.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.top.equalTo(conV.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        if self.isShowCancel {
            
            //删除按钮
            alertContainerView.addSubview(leftButton)
            leftButton.snp.makeConstraints { (make) in
                make.top.equalTo(rightButton.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(40)
            }
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
    
    func getImageWithBoudleName(imgName: String) -> UIImage{
        
        var associateBundleURL = Bundle.main.url(forResource: "Frameworks", withExtension: nil) ?? URL.init(string: "")
        associateBundleURL = associateBundleURL?.appendingPathComponent("RayKit")
        associateBundleURL = associateBundleURL?.appendingPathExtension("framework")
        let associateBunle: Bundle = Bundle.init(url: associateBundleURL!) ?? Bundle()
        
        associateBundleURL = associateBunle.url(forResource: "RayKit", withExtension: "bundle")
        let bundle = Bundle.init(url: associateBundleURL!)

        return UIImage.init(named: imgName, in: bundle, compatibleWith: nil) ?? UIImage()
    }
}


private class AlertContainerView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01 ){
            return nil
        }
        let resultView  = super.hitTest(point, with: event)
        if resultView != nil {
            return resultView
        }else{
            for subView in self.subviews.reversed() {
      // 这里根据层级的不同，需要遍历的次数可能不同，看需求来写，我写的例子是一层的
                let convertPoint : CGPoint = subView.convert(point, from: self)
                let hitView = subView.hitTest(convertPoint, with: event)
                if (hitView != nil) {
                    return hitView
                }
            }
        }
        return nil
    }
}
