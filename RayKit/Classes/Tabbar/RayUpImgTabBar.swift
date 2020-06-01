//
//  RayUpimgTabBar.swift
//  Alamofire
//
//  Created by admin on 2020/4/20.
//

import UIKit

class RayUpImgTabBar: UITabBar {

    // 声明一个block变量
    var dateSelectBlock: selectBlock?
    // 按钮的数据
    var dataDic = Dictionary<String,Any>()
    // 改变第几个tabbar
    var page = 0
    // 总共几个
    var total = 0
    //配置
//    var tabBarCon = tabbarConfig()
    
    
    // 懒加载中间的按钮
    lazy var plusButton: UIButton = {
        
        let plusButton = UIButton()
        plusButton.setImage(UIImage.init(named: self.dataDic["img"] as! String), for: .normal)
        plusButton.setImage(UIImage.init(named: self.dataDic["selectImg"] as! String), for: .highlighted)
        plusButton.titleLabel?.font = tabBarCon.textSize
        plusButton.setTitle(self.dataDic["text"] as? String, for: .normal)
        plusButton.setTitleColor(tabBarCon.textNormalColer, for: .normal)

        let buttonImg: UIImage? = plusButton.image(for: .normal)
        let titleWidth = self
        plusButton.titleEdgeInsets = UIEdgeInsets.init(top: buttonImg!.size.height, left: -buttonImg!.size.height, bottom: -15, right: 0)
        plusButton.imageEdgeInsets = UIEdgeInsets.init(top: -15, left: 0, bottom: 0, right: -20)
        plusButton.frame = CGRect.init(x: 0, y: 0, width: plusButton.imageView!.image!.size.width, height: plusButton.imageView!.image!.size.height + 40)
        plusButton.addTarget(self, action: #selector(selectFunc), for: .touchUpInside)
        return plusButton
    }()

    // MARK: - select
    @objc func selectFunc(){
        if dateSelectBlock != nil{
            
            self.dateSelectBlock!()
        }
    }
    
    func initBtn(_ data: Dictionary<String,Any>, _ page: Int, _ totalPage: Int){
        
        self.dataDic = data
        self.page = page
        self.total = totalPage
        self.addSubview(self.plusButton)
    }
 
    // MARK: - 重写父类方法必须写
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - 添加按钮
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - 重新布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置中间的按钮的位置
        let w = self.frame.width / CGFloat(self.total)

        let x = w * CGFloat(self.page) + (w / 2.0)
        let y = self.frame.height * 0.1
        self.plusButton.center = CGPoint.init(x: x, y: y)
    }
    
    // MARK: - 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        /// 判断是否为根控制器
        if self.isHidden {
            /// tabbar隐藏 不在主页 系统处理
            return super.hitTest(point, with: event)
            
        }else{
            /// 将单钱触摸点转换到按钮上生成新的点
            let onButton = self.convert(point, to: self.plusButton)
            /// 判断新的点是否在按钮上
            if self.plusButton.point(inside: onButton, with: event){
                return plusButton
            }else{
                /// 不在按钮上 系统处理
                return super.hitTest(point, with: event)
            }
        }
    }
}
