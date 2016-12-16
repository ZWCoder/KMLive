//
//  KMRootViewController.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/15.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

class KMRootViewController: UITabBarController {

    var childVCs = [[String:String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
          setupChildControllers()
        
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupChildControllers() {
        
        let dataArray = [
            ["childVC":"KMHomeViewController","title":"首页","imageName":"btn_home"],
            ["childVC":"KMLiveViewController","title":"直播","imageName":"btn_live"],
            ["childVC":"KMFollowViewController","title":"关注","imageName":"btn_column"],
            ["childVC":"KMMeViewController","title":"我的","imageName":"btn_user"]]
        
        var childVCs = [UIViewController]()
        
        for i in 0..<dataArray.count {
            
            childVCs.append(addChildVC(dataArray[i]))
        }
        
        viewControllers = childVCs
    }
    
   private func addChildVC(_ dict:[String:String]) -> UIViewController {
    
          guard let clsName = dict["childVC"],
                let nameSpace = Bundle.main.infoDictionary?["CFBundleName"] as? String,
                let cls = NSClassFromString(nameSpace+"."+clsName) as? UIViewController.Type,
                let title = dict["title"],
                let imageName = dict["imageName"]
            else {
                return UIViewController()
    }
    
    let vc = cls.init()
    vc.title = title
    vc.tabBarItem.image = UIImage(named: imageName)
    vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
    
    let nav = KMNavigationViewController(rootViewController: vc)
    
    return nav

    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
