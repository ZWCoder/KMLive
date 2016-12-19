//
//  KMHomeViewController.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/15.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

class KMHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func historyItemClick(){
    
    }
    
    @objc func searchItemClick(){
        
    }
    
    @objc func qrCodeItemClick(){
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate lazy var pageTitleView:KMPageTitleView = {[weak self] in
        let titleViewFrame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 40)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = KMPageTitleView(frame: titleViewFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()

    
    fileprivate lazy var pageContentView:KMPageContentView = {[weak self] in
        
        let frame = CGRect(x: 0, y: 64+40, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 49 - 40)
        var childVCs = [UIViewController]()
        childVCs.append(KMRecommendViewController())
        childVCs.append(KMGameViewController())
        childVCs.append(KMAmuseViewController())
        childVCs.append(KMFunnyViewController())
        let pageContentView = KMPageContentView(frame: frame, childVCs: childVCs, parentVC: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    

}


// MARK:- 设置UI界面
extension KMHomeViewController{
    
    fileprivate func setupUI(){
        
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        // 1.设置导航栏
        setupNavigationBar()
        // 2
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
    }
    
    fileprivate func setupNavigationBar(){

        let logoItem = UIBarButtonItem(imageName: "logo")
        navigationItem.leftBarButtonItem  = logoItem
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", size: size, target: self, action: #selector(historyItemClick))
        let searchItem = UIBarButtonItem(imageName: "btn_search", size: size, target: self, action: #selector(searchItemClick))
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", size: size, target: self, action: #selector(qrCodeItemClick))
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]
        
    }
}

extension KMHomeViewController:KMPageContentViewDelegate{

    func pageContentView(_ pageContentView: KMPageContentView, progress: CGFloat, soureIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleViewWithProgress(progress, sourceIndex: soureIndex, targetIndex: targetIndex)
    }
    
}


extension KMHomeViewController:KMPageTitleViewDelegate{
    
    func pageTitleView(_ pageTitleView: KMPageTitleView, selectedIndex index: Int) {
        
        pageContentView.setCurrentIndex(index)
    }
}






