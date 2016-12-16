//
//  String+Additions.swift
//  KMDriver
//
//  Created by 联合创想 on 16/11/30.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

extension String {

    func cacheDir() -> String {
        
        // 1.获取缓存目录的路径
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        // 2.生成缓存路径
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        
        return filePath
        
    }
    
    
    func docDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        return filePath
    }
    
    func tmpDir() -> String {
        // 1.获取缓存目录的路径
        let path = NSTemporaryDirectory()
        
        // 2.生成缓存路径
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        
        return filePath
        
    }
    
    
 
  
}
