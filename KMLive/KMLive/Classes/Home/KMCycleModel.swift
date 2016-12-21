//
//  KMCycleModel.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/21.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

class KMCycleModel: NSObject {
    // 标题
    var title : String = ""
    // 展示的图片地址
    var pic_url : String = ""
    
    var room:[String:AnyObject]?{
        didSet{
                guard let room = room else { return  }
           anchor =  KMAnchorModel.yy_model(with: room)
        }
    }
    
    var anchor:KMAnchorModel?
    
}
