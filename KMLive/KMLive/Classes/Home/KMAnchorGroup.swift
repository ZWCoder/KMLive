//
//  KMAnchorGroup.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/20.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

class KMAnchorGroup: NSObject {

    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    var room_list:[[String:NSObject]]?{
    
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list {
                
                anchors.append(KMAnchorModel.yy_model(withJSON: dict )!)
            }
          
        }
    }
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    
    /// 定义主播的模型对象数组
    lazy var anchors : [KMAnchorModel] = [KMAnchorModel]()
}
