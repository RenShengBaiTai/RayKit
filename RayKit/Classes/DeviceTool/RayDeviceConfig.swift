//
//  RayDeviceConfig.swift
//  Alamofire
//
//  Created by admin on 2020/4/24.
//
import UIKit

// 屏幕宽高
public let RayScreenWidth = UIScreen.main.bounds.size.width
public let RayScreenHeight = UIScreen.main.bounds.size.height

// 比例高度
public func RayScreenScaleHeight (_ height: CGFloat) -> CGFloat{
    return height * RayScreenWidth / 375.0
}

// 电池栏
public func RayStatusBarHeight() -> CGFloat {
    return  RayScreenHeight / RayScreenWidth > 2 ? 44 :20;
}

// 导航栏
public func RayNavBarHeight() -> CGFloat{
    return RayStatusBarHeight() + 44
}

// tabbar
public let RayTabBarHeight = 49

// tabbar 底部
public func RayTabBarBottomHeight() -> CGFloat {
    return  RayScreenHeight / RayScreenWidth > 2 ? 34 :0;
}

// 渠道
public let RayChannel = "AppStore"

// 版本
public func RayCurrentAppVersion() -> String {
    
    let infoDic = Bundle.main.infoDictionary
    return infoDic?["CFBundleShortVersionString"] as! String
}

// 系统版本
public func RaySystemVersion() -> String {
    
    return UIDevice.current.systemVersion
}

// 最上层VC
public var RayTopVC: UIViewController? {
    
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}


// mark --
// 颜色
// 主色
public let RayMainColor = UIColor.init(hexString: "#F4B237")
//背景色
public let RayBackGroudColor = UIColor.init(hexString: "#F6F6F6")
//线条颜色
public let RayLineColor = UIColor.init(hexString: "#EBEBEB")
//文字颜色
public let RayBlackTextColor333 = UIColor.init(hexString: "#333333")
public let RayBlackTextColor666 = UIColor.init(hexString: "#666666")
public let RayBlackTextColor999 = UIColor.init(hexString: "#999999")


// mark -- 私有方法
// 获取最上方的VC
private func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}
