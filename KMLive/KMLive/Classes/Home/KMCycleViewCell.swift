//
//  KMCycleViewCell.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/21.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

class KMCycleViewCell: UICollectionViewCell {
    
    var cycleModel:KMCycleModel?{
        didSet{
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            
            iconImage.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
            
            maskLabel.text = cycleModel?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate lazy var iconImage:UIImageView = {
        let iconImage = UIImageView()
        return iconImage
    }()
    
    fileprivate lazy var cycleMaskView:UIView = {
        let maskView = UIView()
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.3
        return maskView
    }()
    
    fileprivate lazy var maskLabel:UILabel = {
        let maskLabel = UILabel()
        maskLabel.textColor = UIColor.white
        return maskLabel
    }()
}


extension KMCycleViewCell{
    
    fileprivate func setupUI(){
        
        addSubview(iconImage)
        addSubview(cycleMaskView)
        cycleMaskView.addSubview(maskLabel)
        
        
        _ = iconImage.xmg_Fill(referView: self)
        _ = cycleMaskView.xmg_AlignVertical(type: .BottomLeft, referView: self, size: CGSize(width: UIScreen.main.bounds.width, height: 30),offset:CGPoint(x: 0, y: -30))
        _ = maskLabel.xmg_Fill(referView: cycleMaskView)
        
    }
}



