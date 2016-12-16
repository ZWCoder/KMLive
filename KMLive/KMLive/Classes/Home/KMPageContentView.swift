//
//  KMPageContentView.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/16.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit
private let ContentCellID = "ContentCellID"
class KMPageContentView: UIView {
    
    
    fileprivate var childVcs:[UIViewController]
    fileprivate var parentViewController:UIViewController
    
    init(frame: CGRect, childVCs:[UIViewController],parentVC:UIViewController){
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
            
            parentViewController.addChildViewController(childVc)
            
        }
        
        addSubview(collectionView)
    }
}

extension KMPageContentView:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        cell.backgroundColor = UIColor.km_randomColor()
        return cell
        
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
