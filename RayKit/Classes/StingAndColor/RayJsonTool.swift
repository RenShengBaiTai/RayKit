//
//  RayJsonTool.swift
//  Alamofire
//
//  Created by admin on 2020/5/12.
//

public class RayJsonTool {
    
    // JSONString转换为字典
    public class func getDictionaryFromJSONString(jsonString: String) ->Dictionary<String, Any>{
     
        if jsonString.count == 0{
            
            return Dictionary()
        }
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! Dictionary
        }
        return Dictionary()
    }

    // JSONString转换为数组
    public class func getArrayFromJSONString(jsonString: String) ->Array<Any>{
         
        if jsonString.count == 0{
        
            return Array()
        }
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! Array
        }
        return array as! Array
    }

    /**
     字典转换为JSONString
      
     - parameter dictionary: 字典参数
      
     - returns: JSONString
     */
    public class func getJSONStringFromDictionary(dictionary:Dictionary<String, Any>) -> String {
        
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        
        let data : NSData! = try! JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }

    //数组转json
    public class func getJSONStringFromArray(array:Array<Any>) -> String {
         
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("无法解析出JSONString")
            return ""
        }
         
        let data : NSData! = try! JSONSerialization.data(withJSONObject: array, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}
