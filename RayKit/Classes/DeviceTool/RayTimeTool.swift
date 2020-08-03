//
//  RayTimeTool.swift
//  Alamofire
//
//  Created by admin on 2020/5/12.
//

public enum timeType: String {
    case noneType = "YYYY-MM-dd HH:mm:ss"
    case YMDType = "YYYY-MM-dd"
}

public class RayTimeTool{

    // 获取时区的当前时间
    public class func getCurrentDate() -> Date{
        
        let date = Date();
        let timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        guard let interval = timeZone?.secondsFromGMT(for: date) else {
          
            return Date()
        }
        let localeDate = date.addingTimeInterval(Double(interval))
        return localeDate
    }

    // 获取当前时间(使用默认类型)
    public class func getCurrentDate() -> String {

        return  RayTimeTool.getCurrentDateWithType(.noneType)
    }
    
    // 获取当前时间
    public class func getCurrentDateWithType(_ type: timeType) -> String {

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = type.rawValue// 自定义时间格式
        return dateformatter.string(from: RayTimeTool.getCurrentDate())
    }
    
    // 时间戳转换
    public class func getTimeInterval(_ type: timeType, _ timeDouble: Double) -> String {
        
        if timeDouble == 0 {
            
            return ""
        }
        let date: NSDate = NSDate.init(timeIntervalSince1970: timeDouble / 1000 )
        let timeZone = TimeZone(secondsFromGMT: 8 * 3600)
        let dateformatter = DateFormatter()
        dateformatter.timeZone = timeZone
        dateformatter.dateFormat = type.rawValue
        return dateformatter.string(from: date as Date)
    }
    
    // date转string
    public class func getDateToStr(_ date: Date,_ type: timeType) -> String {
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = type.rawValue
        return dateformatter.string(from: date)
    }
    
    /// 获取昨天的0 点（flase） 和 24点（true）
    /// - Parameter flag:
    public class func getYesterdayWithType(_ flag: Bool) -> String{
                     
        return RayTimeTool.getYesterdayWithType(flag, .noneType)
    }
 
    /// 获取昨天的0 点（flase） 和 24点（true）
    /// - Parameter flag:
    public class func getYesterdayWithType(_ flag: Bool, _ type: timeType) -> String{
                     
        let calendar: NSCalendar = NSCalendar.init(identifier: .chinese)!
        let timeZone = TimeZone(secondsFromGMT: 8 * 3600)
        calendar.timeZone = timeZone!
        
         var components: DateComponents
        if type == .noneType {
            
            let unitFlags: NSCalendar.Unit = [
                NSCalendar.Unit.year,
                NSCalendar.Unit.month,
                NSCalendar.Unit.day,
                NSCalendar.Unit.hour,
                NSCalendar.Unit.minute,
                NSCalendar.Unit.second]
            
            components = calendar.components(unitFlags, from: Date())
            components.hour = flag ? 0 : -24
            components.minute = 0
            components.second = 0
        }else {
            
            let unitFlags: NSCalendar.Unit = [
                NSCalendar.Unit.year,
                NSCalendar.Unit.month,
                NSCalendar.Unit.day]
            components = calendar.components(unitFlags, from: Date())
            components.hour = flag ? 0 : -24
        }
             
        guard let date = calendar.date(from: components) else {
        
            return RayTimeTool.getCurrentDate()
        }
        return RayTimeTool.getDateToStr(date, type)
    }
    
    
}
