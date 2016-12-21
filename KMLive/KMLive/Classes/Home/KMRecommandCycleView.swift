//
//  KMRecommandCycleView.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/21.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit
private let kCycleViewH = UIScreen.main.bounds.width * 3 / 8
fileprivate let KMCycleViewCellIdentifier = "KMCycleViewCellIdentifier"

class KMRecommandCycleView: UIView {
    
    var cycleModels:[KMCycleModel]?{
        didSet{
            cycleView.reloadData()
            
            pageController.numberOfPages = cycleModels?.count ?? 0
            
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 100, section: 0)
            cycleView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    fileprivate var cycleTimer:Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        autoresizingMask = UIViewAutoresizing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:--
    fileprivate lazy var cycleView:UICollectionView = {
        let cycleView = UICollectionView(frame: CGRect.zero, collectionViewLayout: KMRecommandCycleLayout())
        cycleView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kCycleViewH)
        cycleView.delegate = self
        cycleView.dataSource = self
        return cycleView
    }()
    
    fileprivate lazy var pageController:UIPageControl = {
        let pageController = UIPageControl()
        pageController.pageIndicatorTintColor = UIColor.darkGray
        pageController.currentPageIndicatorTintColor = UIColor.orange
        return pageController
    }()
}


extension KMRecommandCycleView{
    
    fileprivate func setupUI(){
        addSubview(cycleView)
        addSubview(pageController)
        cycleView.register(KMCycleViewCell.self, forCellWithReuseIdentifier: KMCycleViewCellIdentifier)
        
        _ = pageController.xmg_AlignInner(type: .BottomRight, referView: self, size: CGSize(width:120,height:20), offset: CGPoint(x: -5, y: -5))
    }
}


extension KMRecommandCycleView: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMCycleViewCellIdentifier, for: indexPath) as! KMCycleViewCell
        cell.backgroundColor = UIColor.km_randomColor()
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x +  scrollView.bounds.width * 0.5
        
        pageController.currentPage =  Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
    
}


extension KMRecommandCycleView{

    fileprivate func addCycleTimer(){
        
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    fileprivate func removeCycleTimer(){
        
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext(){
        
        // 1.获取滚动的偏移量
        let currentOffsetX = cycleView.contentOffset.x
        let offsetX = currentOffsetX + cycleView.bounds.width
        
        // 2.滚动该位置
        cycleView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}


class KMRecommandCycleLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: UIScreen.main.bounds.width, height: kCycleViewH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        
    }
}




