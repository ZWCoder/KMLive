//
//  KMPageContentView.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/16.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

protocol KMPageContentViewDelegate:class {
    
    func pageContentView(_ pageContentView: KMPageContentView, progress:CGFloat,soureIndex:Int,targetIndex:Int)
    
}

private let ContentCellID = "ContentCellID"
class KMPageContentView: UIView {
    
    //MARK:-- 定义属性
    fileprivate var childVcs:[UIViewController]
    fileprivate weak var parentViewController:UIViewController?
    fileprivate var startOffsetX:CGFloat = 0
    weak var delegate: KMPageContentViewDelegate?
    fileprivate var isForbidScrollDelegate : Bool = false
    
    init(frame: CGRect, childVCs:[UIViewController],parentVC:UIViewController?){
        childVcs = childVCs
        parentViewController = parentVC
        super.init(frame: frame)
        
        setupUI()
        
            }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK:-- 懒加载
    fileprivate lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: KMPageContentViewLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
}


extension KMPageContentView{
    
    fileprivate func setupUI(){
    
        for childVc in childVcs {
            childVc.view.backgroundColor = UIColor.km_randomColor()
            
            parentViewController?.addChildViewController(childVc)
            
        }
        
        addSubview(collectionView)
    }
}

extension KMPageContentView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)

        let childVC = childVcs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

extension KMPageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        var progress: CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.km_Width
        if currentOffsetX > startOffsetX {// 左滑
            progress =  currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
        
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }
        else
        {
            progress = 1 -  (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
            
        }
        
        delegate?.pageContentView(self, progress: progress, soureIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

extension KMPageContentView{
    
    func setCurrentIndex(_ currentIndex:Int) {
        
        // 1.记录需要进制执行代理方法
        isForbidScrollDelegate = true
        
        
        // 2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
}

class KMPageContentViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        itemSize = (self.collectionView?.bounds.size)!
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        
    }
    
}
