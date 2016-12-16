//
//  KMPageTitleView.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/16.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

class KMPageTitleView: UIView {

     fileprivate var titles:[String]
    
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
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
    
    // MARK:- 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()

    fileprivate lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    

}

// MARK:- 设置UI界面
extension KMPageTitleView{
    
    fileprivate func setupUI(){
    
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的Label
        setupTitleLables()
        
        setupBottomLineAndScrollLine()
        
    }
    
    fileprivate func setupTitleLables(){
    
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - 2
        let labelTop:CGFloat = 0
        
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.purple
            label.textAlignment = .center
            let labelLeft = labelW * CGFloat(index)
            label.frame = CGRect(x: labelLeft, y: labelTop, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
        
        
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: UIScreen.main.bounds.width, height: 0.5)
        addSubview(bottomLine)
        
        guard  let firstLabel = titleLabels.first else{return}
        
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: 0, y: frame.height - 2, width: firstLabel.km_Width, height: 2)
        
    }


}






