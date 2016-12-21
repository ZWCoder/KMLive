//
//  KMRecomandViewModel.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/20.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit
import YYModel
class KMRecomandViewModel {
    lazy var kmAnchorGroups = [KMAnchorGroup]()
     lazy var kmCycleModels : [KMCycleModel] = [KMCycleModel]()
    fileprivate lazy var bigDataGroup : KMAnchorGroup = KMAnchorGroup()
    fileprivate lazy var prettyGroup : KMAnchorGroup = KMAnchorGroup()
}


extension KMRecomandViewModel{
    
    func requestCycleViewData(_ finishCallback : @escaping () -> ()) {
        
        KMNetworkAssitant.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", params: ["version" : "2.300"], finishedCallback: {(result) in

            print(result)
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray
            {
                self.kmCycleModels.append(KMCycleModel.yy_model(with: dict)!)
            }
            
            finishCallback()
        })
    }
    
    func requestData(_ finishCallback:@escaping ()->()) {
        // 1
           let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        let dGroup = DispatchGroup()
        
        
        // 2
        dGroup.enter()
        KMNetworkAssitant.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: parameters, finishedCallback: {(result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.bigDataGroup.tag_name =  "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray{
            
                let model = KMAnchorModel.yy_model(withJSON: dict)
                self.bigDataGroup.anchors.append(model!)
            }
            dGroup.leave()
            
        })
        
        // 3
        dGroup.enter()
        KMNetworkAssitant.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: parameters, finishedCallback: {(result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"

            for dict in dataArray{
                
                let model = KMAnchorModel.yy_model(withJSON: dict)
                self.prettyGroup.anchors.append(model!)
            }

        dGroup.leave()
        })

        
        // 4.定义参数
     
        dGroup.enter()
        KMNetworkAssitant.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", params: parameters, finishedCallback: {(result) in
            
            guard let resultData = result as? [String:Any] else{return}
            
            guard let dataArray = resultData["data"] as? [[String : Any]] else {return}
        
            for dict in dataArray
            {
                 guard let model =  KMAnchorGroup.yy_model(withJSON: dict) else{continue}
                
                if model.anchors.count != 0{
                   self.kmAnchorGroups.append(model)
                }
                
            }
            dGroup.leave()
            
        })
        
        // 5 
        dGroup.notify(queue: DispatchQueue.main, execute: {
            
            self.kmAnchorGroups.insert(self.prettyGroup, at: 0)
            self.kmAnchorGroups.insert(self.bigDataGroup, at: 0)
            print(self.kmAnchorGroups)
            finishCallback()
        })
        
    }
    
    
}
