//
//  RayAlertTool.swift
//  contract
//
//  Created by admin on 2020/5/18.
//  Copyright © 2020 hjdj. All rights reserved.
//

import UIKit


public enum toastPlace {
    case toastTop
    case toastCenter
    case toastBottom
    
    var y: CGFloat {
        switch self {
        case .toastTop:
            return RayScreenHeight / 2
        case .toastCenter:
            return RayScreenHeight / 2
        case .toastBottom:
            return 3 * RayScreenHeight / 4
        }
    }
}

public class RayAlertTool: NSObject {

    public static let alertManager = RayAlertTool()
       
    private override init() {}
    
    var keyWindow = UIApplication.shared.keyWindow
    let rv = UIApplication.shared.keyWindow?.subviews.first as UIView?

    //toast
    var toastBottomView: UIView?
    
    //toast
    public func showToast(content:String, place: toastPlace = .toastBottom, duration:CFTimeInterval=1.5) {
        
        removeToastBottomView()
        let attributes = [NSAttributedString.Key.font: UIFont.RaySystemFont(ofSize: 14)]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let contentLength = content.boundingRect(with: CGSize(width: 1000, height: 36), options: option, attributes: attributes, context: nil).size.width

        var frame = CGRect(x: 0, y: 0, width: RayScreenWidth - 20, height: 36)
        if contentLength + 30 < RayScreenWidth - 20 {
           frame = CGRect(x: 0, y: 0, width: contentLength + 30, height: 36)
        }

        let toastContainerView = UIView()
        toastContainerView.layer.cornerRadius = 10
        toastContainerView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.7)

        let toastContentView = UILabel(frame: frame)
        toastContentView.font = UIFont.RaySystemFont(ofSize: 13)
        toastContentView.textColor = UIColor.white
        toastContentView.text = content
        toastContentView.numberOfLines = 0
        toastContentView.textAlignment = .center
        toastContainerView.addSubview(toastContentView)

        toastBottomView = UIView()
        toastBottomView!.backgroundColor = UIColor.clear
        toastBottomView!.frame = frame
        toastContainerView.frame = frame
        toastBottomView?.center = CGPoint(x: rv?.center.x ?? RayScreenWidth / 2, y: place.y)

        toastBottomView!.addSubview(toastContainerView)
        keyWindow?.addSubview(toastBottomView!)
        keyWindow?.bringSubviewToFront(toastBottomView!)

        toastContainerView.layer.add(AnimationUtil.getToastAnimation(duration: duration), forKey: "animation")

        perform(#selector(removeToastBottomView), with: nil, afterDelay: duration)
    }
    
    //移除toast
    @objc func removeToastBottomView() {
        toastBottomView?.removeFromSuperview()
        toastBottomView = nil
    }
}

class AnimationUtil{
    
    //toast动画
    static func getToastAnimation(duration:CFTimeInterval = 1.5) -> CAAnimation{
        // 大小变化动画
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 1]
        scaleAnimation.values = [0.8, 1]
        scaleAnimation.duration = duration
        
        // 透明度变化动画
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimaton.keyTimes = [0, 1]
        opacityAnimaton.values = [0.5, 1]
        opacityAnimaton.duration = duration
        
        // 组动画
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, opacityAnimaton]
        //动画的过渡效果1. kCAMediaTimingFunctionLinear//线性 2. kCAMediaTimingFunctionEaseIn//淡入 3. kCAMediaTimingFunctionEaseOut//淡出4. kCAMediaTimingFunctionEaseInEaseOut//淡入淡出 5. kCAMediaTimingFunctionDefault//默认
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        animation.duration = duration
        animation.repeatCount = 0// HUGE
        animation.isRemovedOnCompletion = true
        
        return animation
    }
}
