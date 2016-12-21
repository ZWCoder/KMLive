//
//  KMRecommendViewController.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/16.
//  Copyright © 2016年 KMXC. All rights reserved.
//  关注

import UIKit

fileprivate let kNormalItemW = (UIScreen.main.bounds.width - 3 * 10) / 2
fileprivate let kNormalItemH = kNormalItemW * 3 / 4
fileprivate let kPrettyItemH = kNormalItemW * 4 / 3
fileprivate let kCycleViewH = UIScreen.main.bounds.width * 3 / 8

fileprivate let KMRecommendNormalCellIdentifier = "KMRecommendNormalCellIdentifier"
fileprivate let KMRecommendPrettyCellIdentifier = "KMRecommendPrettyCellIdentifier"
fileprivate let KMRecommendHeaderIdentifier = "KMRecommendHeaderIdentifier"

class KMRecommendViewController: UIViewController {

     //MARK:-- 定义属性
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        view.backgroundColor = UIColor.yellow
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:--懒加载
    fileprivate lazy var collectionView:UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let collection = UICollectionView(frame:frame, collectionViewLayout: KMRecommendViewLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collection.register(KMRecommandNormalCell.self, forCellWithReuseIdentifier: KMRecommendNormalCellIdentifier)
        collection.register(KMRecommandPrettyCell.self, forCellWithReuseIdentifier: KMRecommendPrettyCellIdentifier)

        collection.register(KMRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KMRecommendHeaderIdentifier)
        collection.backgroundColor = UIColor.white
        return collection
    }()

    fileprivate lazy var recomendVM:KMRecomandViewModel = KMRecomandViewModel()
    
    fileprivate lazy var cycleView:KMRecommandCycleView = {
        let cycleView = KMRecommandCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: UIScreen.main.bounds.width, height: kCycleViewH)
        return cycleView
    }()
    
}


//MARK:--
extension KMRecommendViewController{
    
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
    }
}


extension KMRecommendViewController{

    func loadData() {
        
        recomendVM.requestData { 
            self.collectionView.reloadData()
            
            
        }
        
        recomendVM.requestCycleViewData { 
            self.cycleView.cycleModels = self.recomendVM.kmCycleModels
        }

    }
}

//MARK:--UICollectionViewDelegate,UICollectionViewDataSource
extension KMRecommendViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recomendVM.kmAnchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recomendVM.kmAnchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  anchor  = recomendVM.kmAnchorGroups[indexPath.section].anchors[indexPath.item]
        
  
        
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMRecommendPrettyCellIdentifier, for: indexPath) as! KMRecommandPrettyCell
                cell.anchor = anchor
                cell.backgroundColor = UIColor.white
            return cell
        }else
        {
           let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMRecommendNormalCellIdentifier, for: indexPath) as! KMRecommandNormalCell
                cell.anchor = anchor
                cell.backgroundColor = UIColor.white
            return cell
        }
       
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KMRecommendHeaderIdentifier, for: indexPath)
        
        headerView.backgroundColor = UIColor.yellow
        
        return headerView
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}


//MARK:--
class KMRecommendViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        let itemW = (UIScreen.main.bounds.width - 30) * 0.5
        let itemH = itemW * 3 / 4
        
        itemSize = CGSize(width: itemW, height: itemH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 10
        headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        
        sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}


//MARK:--  KMRecommendHeaderView
class KMRecommendHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:--
    fileprivate lazy var sectionLine:UIView = {
        let line = UIView()
        line.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 10)
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    fileprivate lazy var iconImage:UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "home_header_phone")
        iconImage.frame = CGRect(x: 10, y: 15, width: 18, height: 20)
        return iconImage
    }()
    
    fileprivate lazy var sectionLabel:UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: self.iconImage.km_Right + 10, y: self.iconImage.km_Top, width: 50, height: 20)
        label.text = "颜值"
        return label
    }()
    
    fileprivate lazy var moreButton:UIButton = {
        let button = UIButton()
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        return button
    }()
    
    
}

extension KMRecommendHeaderView {
    
    fileprivate func setupUI(){
        
        addSubview(sectionLine)
        addSubview(iconImage)
        addSubview(sectionLabel)
        addSubview(moreButton)
        
        
        _ = moreButton.xmg_AlignInner(type: .TopRight, referView: self, size: nil,offset:CGPoint(x: -10, y: 10))
    }
}




