//
//  RayButtonExtension.swift
//  RayKit
//
//  Created by admin on 2020/7/15.
//

//MARK: -定义button相对label的位置
public enum RayButtonEdgeInsetsStyle {
    case Top
    case Left
    case Right
    case Bottom
}

public extension UIButton {

    public func layoutButton(style: RayButtonEdgeInsetsStyle, imageTitleSpace: CGFloat) {
        
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        var labelWidth: CGFloat = self.titleLabel?.frame.size.width ?? 0
        var labelHeight: CGFloat = self.titleLabel?.frame.size.height ?? 0
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .Top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
            break;
        case .Left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2, bottom: 0, right: imageTitleSpace)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2, bottom: 0, right: -imageTitleSpace/2)
            break;
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-imageTitleSpace/2, right: -labelWidth)
            titleEdgeInsets = UIEdgeInsets(top: -imageHeight!-imageTitleSpace/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
        case .Right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-imageTitleSpace/2, bottom: 0, right: imageWidth!+imageTitleSpace/2)
            break;
        }
    }
}
