//
//  RayImageTool.swift
//  contract
//
//  Created by admin on 2020/5/28.
//  Copyright © 2020 hjdj. All rights reserved.
//

import UIKit

public class RayImageTool: NSObject {

    
    public static func changeImgSize(_ img: UIImage) -> UIImage {
    
        RayImageTool.changeImgSize(img, img.size.width/3, img.size.height/3)
    }
    
    public static func changeImgSize(_ img: UIImage, _ width: CGFloat, _ height: CGFloat) -> UIImage {
        
        // 设定需要修改的图片的大小
        let sizeChange = CGSize(width: width, height: height)
        // 打开图片编辑模式
        UIGraphicsBeginImageContextWithOptions(sizeChange, false, 0.0)
        // 修改图片长和宽
        img.draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
        // 生成新图片
        guard let imageDate = UIGraphicsGetImageFromCurrentImageContext() else { return img }
        // 关闭图片编辑模式
        UIGraphicsEndImageContext()
        
        return imageDate
    }
    
    // 获取私有库bundle 图片
    public static func getBundleImage(imageName: String, bundleName: String, targetClass: AnyClass) -> UIImage{
        
        let scale = UIScreen.main.scale
        let curB = Bundle.init(for: targetClass)
        let imgName = String.init(format: "%@@%.0fx.png", imageName, scale)
        let dir = bundleName + ".bundle"
        let path = curB.path(forResource: imgName, ofType: nil, inDirectory: dir)
        return UIImage.init(contentsOfFile: path ?? "") ?? UIImage()
    }
}
