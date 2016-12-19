//
//  KMPageTitleView.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/16.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


protocol KMPageTitleViewDelegate:class {
    func pageTitleView(_ pageTitleView:KMPageTitleView,selectedIndex index:Int)
}

class KMPageTitleView: UIView {

    
    // MARK:- 定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles:[String]
    weak var delegate:KMPageTitleViewDelegate?
    
    
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
            //label.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2, alpha: 1.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            let labelLeft = labelW * CGFloat(index)
            label.frame = CGRect(x: labelLeft, y: labelTop, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick))
            label.addGestureRecognizer(tapGes)
            
        }
        
        
    }
    
    func titleLabelClick(tapGes:UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else { return  }
        if currentLabel.tag == currentIndex {
            return
        }
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        //currentLabel.textColor = UIColor(red: kSelectColor.0, green:kSelectColor.1, blue: kSelectColor.2,alpha:1.0)
        //oldLabel.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2,alpha:1.0)
        
         currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        currentIndex = currentLabel.tag
        
        let scrollLineX =  CGFloat(currentIndex) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.km_Left = scrollLineX
        })
        
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
        
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: UIScreen.main.bounds.width, height: 0.5)
        addSubview(bottomLine)
        
        guard  let firstLabel = titleLabels.first else{return}
        //firstLabel.textColor = UIColor(red: kSelectColor.0, green: kSelectColor.1, blue: kSelectColor.2, alpha: 1.0)
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: 0, y: frame.height - 2, width: firstLabel.km_Width, height: 2)
        
    }


}


// MARK:- 对外暴露的方法
extension KMPageTitleView{
    func setTitleViewWithProgress(_ progress:CGFloat,sourceIndex:Int,targetIndex:Int){
    
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.km_Left - sourceLabel.km_Left
        let moveX = moveTotalX * progress
        scrollLine.km_Left = sourceLabel.km_Left + moveX

       // let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)

        // 3.2.变化sourceLabel
       // sourceLabel.textColor = UIColor(red: kSelectColor.0 - colorDelta.0 * progress, green: kSelectColor.1 - colorDelta.1 * progress, blue: kSelectColor.2 - colorDelta.2 * progress, alpha: 1.0)
        sourceLabel.textColor = UIColor.darkGray
        // 3.2.变化targetLabel
        //targetLabel.textColor = UIColor(red: kNormalColor.0 + colorDelta.0 * progress, green: kNormalColor.1 + colorDelta.1 * progress, blue: kNormalColor.2 + colorDelta.2 * progress, alpha: 1.0)
        targetLabel.textColor = UIColor.orange
        
        // 4.记录最新的index
        currentIndex = targetIndex
        
    }
}


