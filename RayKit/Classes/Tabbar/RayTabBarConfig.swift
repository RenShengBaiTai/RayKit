//
//  RayTabBarConfig.swift
//  Alamofire
//
//  Created by admin on 2020/4/22.
//

import UIKit

// 类型
public enum TabBarType {
    case common //UItabBar
    case commonBadge //自定义badge
    case onlyImage //只是显示图片（模仿淘宝）
    case upImage //放大按钮
}

// 配置
public struct tabBarConfig {
    
    let textSize = UIFont.RaySystemFont(ofSize: 12.0)
    let textSelectColer = RayMainColor
    let textNormalColer = UIColor.init(hexString: "#C4C4C4")
    let badgeImg = ""
    let badgeBackColer = UIColor.red
}

// badge 类型
public enum badgeType {
    
    case common // 系统默认，显示数字
    case noNumber // 显示小红点，不显示数字
    case showImg // 显示 tabBarConfig.badgeImg
}

// badgeType
public let badgeT: badgeType = .noNumber
//tabBarConfig
public let tabBarCon: tabBarConfig = tabBarConfig()

//按钮的回调
public typealias selectBlock = ()->()

public let raytext = 1
