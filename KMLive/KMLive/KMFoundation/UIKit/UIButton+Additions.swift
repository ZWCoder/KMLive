//
//  UIButton+Additions.swift
//  KMDriver
//
//  Created by 联合创想 on 16/11/28.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

extension UIButton {

    convenience init(kmFrame:CGRect, title: String, fontSize:CGFloat = 16, titleColor:UIColor, hightLightColor:UIColor, action:AnyObject , selector:Selector) {

        self.init()
        
        setTitle(title, for: .normal)
        frame = kmFrame
        setTitleColor(titleColor, for: .normal)
        setTitleColor(hightLightColor, for: .highlighted)
        addTarget(action, action: selector, for: .touchUpInside)
        
    }
    
    
    convenience init(title: String, fontSize:CGFloat = 16, titleColor:UIColor, hightLightColor:UIColor, action:AnyObject , selector:Selector) {
        
        self.init()
        self.sizeToFit()
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(hightLightColor, for: .highlighted)
        addTarget(action, action: selector, for: .touchUpInside)
        
    }
    
    convenience init(title: String, fontSize:CGFloat = 16, titleColor:UIColor, hightLightColor:UIColor) {
        
        self.init()
        self.sizeToFit()
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(hightLightColor, for: .highlighted)
        
    }
    
}
