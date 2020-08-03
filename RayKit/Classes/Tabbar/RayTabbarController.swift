//
//  RayTabbar.swift
//  RayKit
//
//  Created by admin on 2020/4/17.
//

import UIKit

public class RayTabbarController: UITabBarController, UITabBarControllerDelegate{
    
    //数据源
    var dataArr = [Any]()
    //类型
    var tabberType: TabBarType = .common
    //是否加载动画
    var isAnimation = false
    //如果是 onlyImage 或者 upImage 模式，指定第几个tabbar
    var imageIndex: Int = 0
    //textcolor
    let textColor = UIColor.green
    //textSize
    let textSize = UIFont.RaySystemFont(ofSize: 14)
    //rayUpimgTabBar
    lazy var rayUpimgTabBar = { () -> RayUpImgTabBar in
        
        let rayUpimgTabBar = RayUpImgTabBar()
        rayUpimgTabBar.initBtn(self.dataArr[self.imageIndex] as? Dictionary<String,Any> ?? Dictionary<String,Any>(), self.imageIndex, self.dataArr.count)
        rayUpimgTabBar.isTranslucent = false
        weak var weakSelf = self
        rayUpimgTabBar.dateSelectBlock = {

            let data = weakSelf?.dataArr[self.imageIndex] as? Dictionary<String,Any> ?? Dictionary<String,Any>()
            let vc = data["vc"] as? UIViewController
            weakSelf?.definesPresentationContext = true
            vc?.modalPresentationStyle = .custom
            weakSelf?.present(vc ?? UIViewController(), animated: true, completion: nil)
        }
        return rayUpimgTabBar
    }()
    //onlyImage
    lazy var onlyImageTabBar = {() -> RayOnlyImageTabBar in
        
        let onlyImageTabBar = RayOnlyImageTabBar()
        onlyImageTabBar.initBtn(self.dataArr[self.imageIndex] as? Dictionary<String,Any> ?? Dictionary<String,Any>(), self.imageIndex, self.dataArr.count)
        onlyImageTabBar.isTranslucent = false
        weak var weakSelf = self
        onlyImageTabBar.dateSelectBlock = {
            
            weakSelf?.selectedIndex = (weakSelf?.imageIndex ?? 0) as Int
            onlyImageTabBar.plusButton.isHidden = false;
            weakSelf?.viewControllers?[self.imageIndex].tabBarItem.title = ""
        }
        return onlyImageTabBar
    }()
  
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = (self as UITabBarControllerDelegate);
    }
    
    /// 初始化方法
    /// - Parameters:
    ///   - type: TabBarType
    ///   - data: tabbar 的数据 [{vc:xxx,navText:xx，tabText:xx,img:xxx,selectImg:xxx}]
    ///   - animaion: isAnimation
    ///   - page: imageIndex
    public func initTabbar(_ type: TabBarType, _ data: Array<Any>, _ animaion: Bool, _ page: Int){

        self.isAnimation = animaion
        self.imageIndex = page
        self.dataArr = data
        self.tabberType = type

        switch type {
            case .commonBadge:

            break
            case .onlyImage:
                self.initOnlyImgTab()
            break
            case .upImage:
                self.initUpimgTab()
            break
            default:
                self.initCommonTab()
            break
        }
    }
    
    func initOnlyImgTab() {
        
        self.setValue(self.onlyImageTabBar, forKey: "tabBar")
        self.initCommonTab()
    }
    
    func initUpimgTab(){
        
        self.setValue(self.rayUpimgTabBar, forKey: "tabBar")
        self.initCommonTab()
    }
    
    func initCommonTab(){
        
        var nvcArray = [UINavigationController]()
        for i in 0 ..< self.dataArr.count{
            
            let newItem = self.dataArr[i] as? Dictionary<String,Any>

            // 在upImage 模式下，不用创建特殊的那一个tabbarItme
            if (self.tabberType == .upImage) && i == (self.imageIndex){
                
                nvcArray.append(UINavigationController())
                continue
            }
            
            // common 模式
            let vc = self.creatTabbarView(viewController: newItem?["vc"] as! UIViewController,
                                          image: newItem?["img"] as! String,
                                          selectImage: newItem?["selectImg"] as! String,
                                          title: newItem?["tabText"] as! String,
                                          navTitle: newItem?["navText"] as! String,
                                          tag: i)
            nvcArray.append(vc)
        }
        self.tabBar.barTintColor = UIColor.white //背景
        self.tabBar.tintColor = tabBarCon.textSelectColer
        self.viewControllers = nvcArray
    }
    
    func creatTabbarView(viewController: UIViewController, image: String, selectImage: String, title: String, navTitle: String, tag: NSInteger) -> (UINavigationController){
        
        // alwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
        viewController.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImage )?.withRenderingMode(.alwaysOriginal)
        viewController.title = navTitle
        viewController.tabBarItem.title = title
        viewController.tabBarItem.tag = tag
        return RayNavigationViewController.init(rootViewController: viewController)
    }
    
    // MARK: - UITabBarControllerDelegate
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        if self.tabberType == .onlyImage {
            
            self.onlyImageTabBar.plusButton.isHidden = true
            let item = self.dataArr[self.imageIndex] as? Dictionary<String,Any>
            self.viewControllers?[self.imageIndex].tabBarItem.title = item?["text"] as? String
        }
        
        return true
    }
    
    /**
     点击TabBar的时候调用
     */
    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if self.isAnimation {
            
            self.touchAnimation(index: item.tag)
        }
    }
    
    func touchAnimation(index:NSInteger){
        
        // 得到当前tabbar的下标
        var tabbarbuttonArray:NSMutableArray!
        tabbarbuttonArray = NSMutableArray.init()
        for tabBarButton:UIView in self.tabBar.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!){
                tabbarbuttonArray.add(tabBarButton)
            }
        }
        /**
         对当前下标的tabbar使用帧动画
         可以根据UI的具体要求进行动画渲染
         */
        let pulse = CABasicAnimation.init(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        pulse.duration = 0.2
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = 0.7
        pulse.toValue = 1.3
        let thisView = tabbarbuttonArray[index] as! UIView
        thisView.layer.add(pulse, forKey: nil)
        
//        self.playSoundEffect(name: "music", type: "wav")
    }
    
    // MARK: - 播放音效的方法
//    func playSoundEffect(name:String, type:String) {
//        //获取声音地址
//        let resoucePath = Bundle.main.path(forResource: name, ofType: type)
//        var soundID: SystemSoundID = 0
//        //地址转换
//        let baseURL = NSURL(fileURLWithPath: resoucePath!)
//        //赋值
//        AudioServicesCreateSystemSoundID(baseURL, &soundID)
//        //播放声音
//        AudioServicesPlaySystemSound(soundID)
//    }
}


