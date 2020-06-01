//
//  RayAppCommonTool.swift
//  Alamofire
//
//  Created by admin on 2020/5/22.
//

import UIKit

public class RayAppCommonTool: NSObject {
    
    
    /// 拨打电话
    public class func callPhone(_ phone: String) {
        
        if phone.isEmpty {
            print("电话号码异常")
        } else {
            
            var tel = "tel://"+phone
            //去掉空格-不然有些电话号码会使 URL 报 nil
            tel = tel.replacingOccurrences(of: " ", with: "", options: .literal, range: nil);
            print(tel)
            if let urls = URL(string: tel){
                
                //ios 10.0以上和一下调用不同的方法拨打电话-默认都会弹框询问
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(urls, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: {
                       (success) in
                        print("Open \(phone): \(success)")
                    })
                } else {
                    UIApplication.shared.openURL(urls)
                }
            }else{
                print("url 为空!")
            }
        }
        
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
