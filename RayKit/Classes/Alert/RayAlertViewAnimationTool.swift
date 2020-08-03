//
//  RayAlertViewAnimationTool.swift
//  RayKit
//
//  Created by admin on 2020/7/11.
//

class RayAlertViewAnimationTool {

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
       animation.timingFunction = CAMediaTimingFunction(name: .linear)
       
       animation.duration = duration
       animation.repeatCount = 0// HUGE
       animation.isRemovedOnCompletion = true
       
       return animation
    }

    //弹窗show动画
    static func getAlertShowAnimation() -> CAAnimation {
        // 大小变化动画
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 1]
        scaleAnimation.values = [0.1, 1]
        scaleAnimation.duration = 0.2
        scaleAnimation.isRemovedOnCompletion = false
        
        // 透明度变化动画
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimaton.keyTimes = [0, 1]
        opacityAnimaton.values = [0.1, 1]
        opacityAnimaton.duration = 0.2
        opacityAnimaton.isRemovedOnCompletion = false
        
        // 组动画
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, opacityAnimaton]
        //动画的过渡效果1. kCAMediaTimingFunctionLinear//线性 2. kCAMediaTimingFunctionEaseIn//淡入 3. kCAMediaTimingFunctionEaseOut//淡出4. kCAMediaTimingFunctionEaseInEaseOut//淡入淡出 5. kCAMediaTimingFunctionDefault//默认
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        animation.duration = 0.2
        animation.repeatCount = 1// HUGE
        animation.isRemovedOnCompletion = false
        
        return animation
    }
    
    //弹窗close动画
    static func getAlertCloseAnimation() -> CAAnimation {
        // 大小变化动画
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        scaleAnimation.fromValue = CATransform3DIdentity
        scaleAnimation.toValue = CATransform3DMakeScale(0.1, 0, 1)
        scaleAnimation.isRemovedOnCompletion = false
        
        // 透明度变化动画
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimaton.keyTimes = [0, 1]
        opacityAnimaton.values = [1, 0.1]
        opacityAnimaton.duration = 0.2
        opacityAnimaton.isRemovedOnCompletion = false
        
        // 组动画
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, opacityAnimaton]
        //动画的过渡效果1. kCAMediaTimingFunctionLinear//线性 2. kCAMediaTimingFunctionEaseIn//淡入 3. kCAMediaTimingFunctionEaseOut//淡出4. kCAMediaTimingFunctionEaseInEaseOut//淡入淡出 5. kCAMediaTimingFunctionDefault//默认
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        animation.duration = 0.2
        animation.repeatCount = 1// HUGE
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        return animation
    }
}
