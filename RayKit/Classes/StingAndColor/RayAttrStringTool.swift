//
//  StringTool.swift
//  contract
//
//  Created by admin on 2020/5/22.
//  Copyright © 2020 hjdj. All rights reserved.
//

import UIKit

public class RayAttrStringTool: NSObject {

    public class func creatAttrString(_ text: String, _ image: UIImage, _ font: Int) -> NSAttributedString{
        
        // NSTextAttachment可以将图片转换为富文本内容
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.bounds = CGRect.init(x: 5, y: -3, width: image.size.width, height: image.size.height)
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
        mutableAttr.append(textAttr)
        mutableAttr.append(mutableImageAttr)
        return mutableAttr.copy() as! NSAttributedString
        
    }
}
