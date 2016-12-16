//
//  UIBarButtonItem+Additions.swift
//  KMDriver
//
//  Created by 联合创想 on 16/11/28.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    // 分类里 使用 便利构造函数 快速创建控件
    convenience init(title:String, fontSize: CGFloat = 16, target:AnyObject?,action:Selector) {
        
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.sizeToFit()
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView:btn)
    }
    
    
}
