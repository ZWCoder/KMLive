//
//  KMNetworkAssitant.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/20.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit
import Alamofire

enum KMMethod {
    case get
    case post
}


class KMNetworkAssitant {

    
    class func requestData(_ type: KMMethod,URLString:String,params:[String:Any]? = nil,finishedCallback:@escaping (_ result:Any) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: params).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                
                print(response.result.error ?? "")
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
        
        
        
    }
    
}
