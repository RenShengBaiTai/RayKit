//
//  RayTabBarManager.swift
//  Alamofire
//
//  Created by admin on 2020/4/23.
//

import UIKit

public class RayTabBarManager {

    
    /// 设置vc 的badge
    /// - Parameters: 只有小红点
    ///   - vc: 当前的vc
    ///   - index: vc 是tabbar 的第几个
    public class func showBadge (_ vc: UIViewController, _ index: NSInteger){
        
        self.showBadge(vc, index, "")
    }
    
    
    /// 设置vc 的badge
    /// - Parameters: 3个类型都可以
    ///   - vc: 当前的vc
    ///   - index: vc 是tabbar 的第几个
    ///   - total: badge的数字
    public class func showBadge (_ vc: UIViewController, _ index: NSInteger, _ total: String){
        
        let badgePoint2 = CGPoint(x: 25, y: -3)
        vc.tabBarController?.tabBar.badgePoint = badgePoint2
        vc.tabBarController?.tabBar.badgeColor = tabBarCon.badgeBackColer

        switch badgeT  {
            case .noNumber:

                vc.tabBarController?.tabBar.badgeSize = CGSize(width: 10, height: 10)
                vc.tabBarController?.tabBar.badgeValue = ""
                vc.tabBarController?.tabBar.badgeImage = UIImage(named: "")
                break
            case .showImg:

                vc.tabBarController?.tabBar.badgeSize = CGSize(width: 20, height: 20)
                vc.tabBarController?.tabBar.badgeImage = UIImage(named: tabBarCon.badgeImg)
                break
            default:

                vc.tabBarController?.tabBar.badgeSize = CGSize(width: 20, height: 20)
                vc.tabBarController?.tabBar.badgeValue = total
                vc.tabBarController?.tabBar.badgeImage = UIImage(named: "")
                break
        }
        vc.tabBarController?.tabBar.showBadgeOnItemIndex(index: index)
    }
    
    /// 清空vc的badge
    /// - Parameters: 所有的样式
    ///   - vc: 当前的vc
    ///   - index: vc 是tabbar 的第几个
    public class func dismissBadge (_ vc: UIViewController, _ index: NSInteger){
        
        vc.tabBarController?.tabBar.hiddenRedPointOnIndex(index: index, animation: true)
    }
}
