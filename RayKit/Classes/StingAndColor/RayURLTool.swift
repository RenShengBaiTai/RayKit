//
//  NetURLTool.swift
//  text
//
//  Created by admin on 2020/5/13.
//  Copyright © 2020 admin. All rights reserved.
//


public class RayURLTool {
    
    public static func getUrlStr (_ dic: Dictionary<String, String>) -> (String){
        
        let keys = dic.keys.sorted()
        let newStr: NSMutableString = ""
        for i in 0..<keys.count {

            let key :String = keys[i]
            var str = keys[i] + "=" + dic[key]!
            if i != keys.count - 1{
                
                str.append("&")
            }
            newStr.append(str)
        }
        return newStr as String
    }
}
