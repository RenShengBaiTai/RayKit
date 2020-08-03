//
//  StringTool.swift
//  contract
//
//  Created by admin on 2020/5/22.
//  Copyright © 2020 hjdj. All rights reserved.
//

import UIKit

public enum AttrStringType {
    case left // 图片在字符串的左边
    case right// 图片在字符串的右边
}

public class RayAttrStringTool: NSObject {

    public class func creatAttrString(_ text: String, _ image: UIImage, _ font: Int) -> NSAttributedString{
        
        return RayAttrStringTool.creatAttrStringWithImgAndStr(text, image, font, type: .right)
    }
    
    /// 字符串和图片拼接
    /// - Parameters:
    ///   - text: 字符串
    ///   - image: 图片
    ///   - font: 文字大小
    ///   - type: 类型
    ///   - space: 文字和图片的间隙
    /// - Returns: attr
    public class func creatAttrStringWithImgAndStr(_ text: String, _ image: UIImage, _ font: Int, type: AttrStringType) -> NSAttributedString{
        
        // NSTextAttachment可以将图片转换为富文本内容
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.bounds = CGRect.init(x: 10, y: -3, width: image.size.width, height: image.size.height)
        attachment.image = image
        
        // 通过NSTextAttachment创建富文本
        // 图片的富文本
        let imageAttr: NSAttributedString = NSAttributedString.init(attachment: attachment)
        let mutableImageAttr: NSMutableAttributedString = NSMutableAttributedString(attributedString: imageAttr)
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.RaySystemFont(ofSize: CGFloat(font)), .baselineOffset: -2]
        mutableImageAttr.addAttributes(attr, range: NSRange(location: 0, length: imageAttr.length))
        
        // 文字的富文本
        let textAttr: NSMutableAttributedString = NSMutableAttributedString.init(string: text, attributes: [.font: UIFont.RaySystemFont(ofSize: CGFloat(font))])
            
        let mutableAttr: NSMutableAttributedString = NSMutableAttributedString()

        // 将图片、文字拼接
        // 如果要求图片在文字的后面只需要交换下面两句的顺序
        if type == .left {
            
            mutableAttr.append(mutableImageAttr)
            mutableAttr.append(textAttr)
        }else{
            
            mutableAttr.append(textAttr)
            mutableAttr.append(mutableImageAttr)
        }
        return mutableAttr.copy() as! NSAttributedString
    }
    
    
    //传入字符串、字体      返回NSMutableAttributedString
    public class func appendStrWithString(str: String, font: CGFloat) -> NSMutableAttributedString {
        
        let attStr = NSMutableAttributedString.init(string: str, attributes: [NSAttributedString.Key.font : UIFont.RaySystemFont(ofSize: font)])
        return NSMutableAttributedString.init(attributedString: attStr)
    }
    
    //传入字符串、字体、颜色      返回NSMutableAttributedString
    public class func appendColorStrWithString(str: String, font: CGFloat, color: UIColor) -> NSMutableAttributedString {
        
        let attStr = NSMutableAttributedString.init(string: str, attributes: [NSAttributedString.Key.font : UIFont.RaySystemFont(ofSize: font),NSAttributedString.Key.foregroundColor: color])
        return NSMutableAttributedString.init(attributedString: attStr)
    }
}
