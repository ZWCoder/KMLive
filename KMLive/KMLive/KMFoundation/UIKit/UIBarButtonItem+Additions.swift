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
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(title:String = "",imageName:String, fontSize: CGFloat = 16,size:CGSize = CGSize.zero, target:AnyObject?,action:Selector) {
        
        let btn = UIButton()
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        if title != "" {
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .normal)
            btn.setTitleColor(UIColor.orange, for: .highlighted)

        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }
        else
        {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setBackgroundImage(UIImage(named:imageName+"_selected"), for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView:btn)
    }
    
    
    
    convenience init(title:String = "",imageName:String, fontSize: CGFloat = 16,size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        if title != "" {
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .normal)
            btn.setTitleColor(UIColor.orange, for: .highlighted)
            
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }
        else
        {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setBackgroundImage(UIImage(named:imageName+"_selected"), for: .highlighted)
        
        self.init(customView:btn)
    }

}
