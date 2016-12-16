//
//  UIView+Additions.swift
//  KMDriver
//
//  Created by 联合创想 on 16/12/8.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Left
    public var km_Left:CGFloat{
        get{
            return self.frame.origin.x
        }
        
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    /// Top
    public var km_Top:CGFloat{
        get{
            return self.frame.origin.y
        }
        
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    /// Right
    public var km_Right:CGFloat{
        get{
            return self.km_Left + self.km_Width
        }
        
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    
    ///Bottom
    public var km_Bottom: CGFloat{
        get{
            return self.km_Top + self.km_Height
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }


    /// Width
    public var km_Width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    /// Height
    public var km_Height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    ///CenterX
    public var km_CenterX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
     /// CenterY
    public var km_CenterY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }

     /// Origin
    public var km_Origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.km_Left = newValue.x
            self.km_Top = newValue.y
        }
    }
    
     /// Size
    public var km_Size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.km_Width = newValue.width
            self.km_Height = newValue.height
        }
    }


}
