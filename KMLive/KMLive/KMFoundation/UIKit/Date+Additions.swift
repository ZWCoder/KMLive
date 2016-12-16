//
//  Date+Additions.swift
//  KMDriver
//
//  Created by 联合创想 on 16/12/10.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

extension Date{

    //WARNING
    // Date 是结构体，需要使用static 声明 类方法
    // NSDate 是类， 需要使用class／static 声明 类方法
    static func dateWithString(formatterStr:String, time:String) -> Date {
    
    let formatter = DateFormatter()
    // 1.2.设置时间的格式
    formatter.dateFormat = formatterStr
    // 1.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
    formatter.locale = Locale(identifier: "en")
     // 1.4转换字符串, 转换好的时间是去除时区的时间
    let createDate = formatter.date(from: time)!
        
    return createDate
    }
    
     //WARNING： 结构体 的分类里，可以 只能 添加 计算型属性。如果想 添加 别的属性，只能使用关联对象
    var descDate:String?{
    
        let calendar = Calendar.current
        
         // 1.判断是否是今天
        if calendar.isDateInToday(self) {
            
              // 1.0获取当前时间和系统时间之间的差距(秒数)
            let since = Int(Date().timeIntervalSince(self))
             // 1.1是否是刚刚
            if since < 60 {
                 return "刚刚"
            }
             // 1.2多少分钟以前
            if since < 60 * 60 {
               return "\(since/60)分钟前"
            }
            
            
            
            // 1.3多少小时以前
            return "\(since / (60 * 60))小时前"
            
        }
        
         // 2.判断是否是昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInTomorrow(self) {
            
            // 昨天: HH:mm
            formatterStr =  "昨天:" +  formatterStr
            
        }
        else
        {
             // 3.处理一年以内
            formatterStr = "MM-dd " + formatterStr
            // 4.处理更早时间

            let comps = calendar.dateComponents([Calendar.Component.year], from: self, to: Date())
            
            if comps.year! >= 1 {
                 formatterStr = "yyyy-" + formatterStr
            }
            
            
        }
        
        
        // 5.1.创建formatter
        let formatter = DateFormatter()
        // 5.2.设置时间的格式
        formatter.dateFormat = formatterStr
        // 5.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = Locale(identifier: "en")
        // 5.4格式化
        
        return formatter.string(from: self)

    }
    

}












