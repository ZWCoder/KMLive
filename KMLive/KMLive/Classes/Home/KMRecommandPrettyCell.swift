//
//  KMRecommandPrettyCell.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/20.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit

class KMRecommandPrettyCell: UICollectionViewCell {
    
    var anchor:KMAnchorModel?{
        
        didSet{
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            
            var onLineStr:String = ""
            if anchor.online >= 10000 {
                onLineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onLineStr = "\(anchor.online)在线"
            }
            
            onlineNumBtn.setTitle(onLineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            
            guard let iconURL = URL(string:anchor.vertical_src) else { return  }
            bgImageView.kf.setImage(with: iconURL)
            
            // 2.所在的城市
            locationBtn.setTitle(anchor.anchor_city, for: UIControlState())
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var bgImageView:UIImageView =  {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "live_cell_default_phone")
        return imageView
    }()

    
    fileprivate lazy var nickNameLabel:UILabel = {
        let label = UILabel()
        label.text = "快马学车"
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.sizeToFit()
        label.textColor = UIColor.white
        
        return label
    }()
    
    fileprivate lazy var locationBtn:UIButton = {
        let button = UIButton ()
        button.setTitle("合肥市", for: .normal)
        button.setImage(UIImage(named:"ico_location"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.sizeToFit()
        button.setTitleColor(UIColor.darkGray, for: .normal)
        
        return button
    }()
    
    fileprivate lazy var onlineNumBtn:UIButton  = {
        let button = UIButton()
        button.setTitle( "666在线", for: .normal)
        button.setImage(UIImage(named:"Image_online"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.alpha = 0.4
        return button
    }()
}


extension KMRecommandPrettyCell{
    fileprivate func setupUI(){
        
        // 1
        addSubview(bgImageView)
        addSubview(nickNameLabel)
        addSubview(locationBtn)
        addSubview(onlineNumBtn)
        
        // 2
        _ = bgImageView.xmg_Fill(referView: self, insets: UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0))
        
        _ = locationBtn.xmg_AlignVertical(type: .BottomLeft, referView: self, size: nil,offset:CGPoint(x: 5, y: -25))
        
        _ = nickNameLabel.xmg_AlignVertical(type: .TopLeft, referView: locationBtn, size: nil,offset:CGPoint(x: -5, y: -15))
        
        _ = onlineNumBtn.xmg_AlignVertical(type: .TopRight, referView: self, size: nil,offset:CGPoint(x: -5, y: 15))
    }
}

