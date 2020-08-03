//
//  RayStatusView.swift
//  RayKit
//
//  Created by admin on 2020/7/23.
//

import UIKit

public enum RayStatusViewType {
    case noData
    case netError
}

public enum RayStatusViewLocation {
    case center
    case top
    case down
}

class RayStatusView: UIView {

    //容器
    lazy var rootV: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    //图片
    lazy var imgV: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    //文字
    lazy var textLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.RaySystemFont(ofSize: 13)
        lab.textColor = RayBlackTextColor333
        lab.textAlignment = .center
        return lab
    }()
    
    //重试
    lazy var btn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.RaySystemFont(ofSize: 14)
        btn.setTitleColor(RayMainColor, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3.0
        btn.layer.borderColor = RayMainColor.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return btn
    }()

    //类型
    var type: RayStatusViewType?
    var location: RayStatusViewLocation?
    var clickClosure: () -> Void?

    let netErrorStr = "网络连接异常，请稍后重试";
    let noDataStr   = "暂无记录";
    let noConStr    = "暂无优惠券记录";
    let viewTopAndDown = 20
    
    init(frame: CGRect, type: RayStatusViewType, location: RayStatusViewLocation, block: @escaping () -> Void){
        self.type = type
        self.location = location
        self.clickClosure = block
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
        self.addSubview(self.rootV)
        self.rootV.addSubview(self.imgV)
        self.rootV.addSubview(self.textLab)
        
        switch (self.type) {
            case .noData://空数据
                self.imgV.image = UIImage.init(named: "RayDataEmpty")
                self.textLab.text = noDataStr;
            case .netError://无网络
                self.imgV.image = UIImage.init(named: "RayNetError")
                self.textLab.text = netErrorStr;
                self.btn.setTitle("点击重试", for: .normal)
                self.rootV.addSubview(self.btn)
            default:
                break;
        }
        
        if (self.location == .top) {
            
            self.imgV.snp.makeConstraints { (make) in
                make.top.centerX.equalTo(self.rootV)
            }
            
            self.textLab.snp.makeConstraints { (make) in
                make.top.equalTo(self.imgV.snp.bottom).offset(14)
                make.centerX.equalTo(self.rootV)
            }

            if (self.type == .netError) {
                
                self.btn.snp.makeConstraints { (make) in
                    make.top.equalTo(self.textLab.snp.bottom).offset(14)
                    make.centerX.equalTo(self.rootV)
                    make.width.equalTo(90)
                    make.height.equalTo(30)
                }
                
                self.rootV.snp.makeConstraints { (make) in
                    make.top.equalTo(viewTopAndDown)
                    make.left.right.equalTo(self)
                    make.bottom.equalTo(self.btn)
                }
            }else{
                
                self.rootV.snp.makeConstraints { (make) in
                    make.top.equalTo(viewTopAndDown)
                    make.left.right.equalTo(self);
                    make.bottom.equalTo(self.textLab)
                }
            }
        }else if (self.location == .down){
            
            if (self.type == .netError) {
                
                self.btn.snp.makeConstraints { (make) in
                    make.bottom.centerX.equalTo(self.rootV)
                    make.width.equalTo(90)
                    make.height.equalTo(30)
                }
                
                self.textLab.snp.makeConstraints { (make) in
                    make.bottom.equalTo(self.btn.snp.top).offset(-14)
                    make.centerX.equalTo(self.rootV)
                }

                self.imgV.snp.makeConstraints { (make) in
                    make.bottom.equalTo(self.textLab.snp.top).offset(-14)
                    make.centerX.equalTo(self.rootV)
                }
            }else{
                
                self.textLab.snp.makeConstraints { (make) in
                    make.bottom.equalTo(-viewTopAndDown)
                    make.centerX.equalTo(self.rootV)
                }
                
                self.imgV.snp.makeConstraints { (make) in
                    make.bottom.equalTo(self.textLab.snp.top).offset(-14)
                    make.centerX.equalTo(self.rootV)
                }
            }
            
            self.rootV.snp.makeConstraints { (make) in
                make.bottom.equalTo(-viewTopAndDown)
                make.left.right.equalTo(self)
                make.top.equalTo(self.imgV)
            }
        }else{//居中
            
            self.imgV.snp.makeConstraints { (make) in
                make.top.centerX.equalTo(self.rootV)
            }
            
            self.textLab.snp.makeConstraints { (make) in
                make.top.equalTo(self.imgV.snp.bottom).offset(14)
                make.centerX.equalTo(self.rootV)
            }

            if (self.type == .netError) {
                
                self.btn.snp.makeConstraints { (make) in
                    make.top.equalTo(self.textLab.snp.bottom).offset(14)
                    make.centerX.equalTo(self.rootV)
                    make.width.equalTo(90)
                    make.height.equalTo(30)
                }
                
                self.rootV.snp.makeConstraints { (make) in
                    make.left.right.equalTo(self)
                    make.bottom.equalTo(self.btn)
                    make.centerY.equalTo(self)
                }
            }else{
                
                self.rootV.snp.makeConstraints { (make) in
                    make.centerY.equalTo(self)
                    make.left.right.equalTo(self)
                    make.bottom.equalTo(self.textLab)
                }
            }
        }
    }
    
    func updateWithType(type: RayStatusViewType) {
        
        switch (type) {
            case .noData://空数据
                
                self.imgV.image = UIImage.init(named: "HTHDataEmpty")
                self.textLab.text = noDataStr
            case .netError://无网络
                
                self.imgV.image = UIImage.init(named: "HTHNetError")
                self.textLab.text = netErrorStr
                self.btn.setTitle("点击重试", for: .normal)
            default:
                break;
        }
    }
    
    @objc func buttonClick() {
        
        if self.clickClosure != nil {
            
            self.clickClosure()
        }
    }
}
