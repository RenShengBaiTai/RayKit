//
//  onlyImageTabBar.swift
//  Alamofire
//
//  Created by admin on 2020/4/22.
//

import UIKit


class RayOnlyImageTabBar: UITabBar {

    // 声明一个block变量
    var dateSelectBlock: selectBlock?
    // 按钮的数据
    var dataDic = Dictionary<String,Any>()
    // 改变第几个tabbar
    var page = 0
    // 总共几个
    var total = 0

    // 懒加载中间的按钮
    lazy var plusButton: UIButton = {
        
        let plusButton = UIButton()
        plusButton.setImage(UIImage.init(named: self.dataDic["img"] as! String), for: .normal)
        plusButton.frame = CGRect.init(x: 0, y: 0, width: plusButton.imageView!.image!.size.width, height: plusButton.imageView!.image!.size.height + 40)
        plusButton.addTarget(self, action: #selector(selectFunc), for: .touchUpInside)
        if self.page != 0 {
            
            plusButton.isHidden = true
        }
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
//       let w = self.frame.width / CGFloat(self.total)
//
//       let x = w * CGFloat(self.page) - (w / 2.0)
//       let y = self.frame.height * 0.1
//       self.plusButton.center = CGPoint.init(x: x, y: y)
//
        // 设置淘宝按钮的位置
        let w = self.frame.width / CGFloat(self.total)
        var index = 0
        for childView:UIView in self.subviews {
            if childView.isKind(of: NSClassFromString("UITabBarButton")!){

                if index == self.page {
                    var isIphoneX:Bool = false
                    let zeroNum:CGFloat = 0
                    // 判断是否是刘海屏
                    if #available(iOS 11.0, *) {
                        isIphoneX = UIApplication.shared.keyWindow!.safeAreaInsets.bottom > zeroNum
                    }
                    
                    if isIphoneX {
                        self.plusButton.frame = CGRect.init(x: w * CGFloat(index), y: 0, width: w, height: self.frame.size.height - 34)
                    }else{
                        self.plusButton.frame = CGRect.init(x: w * CGFloat(index), y: 0, width: w, height: self.frame.size.height )
                    }
                }
                index += 1
            }
        }
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
