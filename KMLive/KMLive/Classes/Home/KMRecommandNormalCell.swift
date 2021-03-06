//
//  KMRecommandNormalCell.swift
//  KMLive
//
//  Created by 联合创想 on 16/12/19.
//  Copyright © 2016年 KMXC. All rights reserved.
//

import UIKit
import Kingfisher

class KMRecommandNormalCell: UICollectionViewCell {
    
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
            
            bgTitleLabel.text = anchor.room_name
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
        imageView.image = UIImage(named: "Img_default")
        return imageView
    }()
    
    fileprivate lazy var vedioIconView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "home_live_cate_normal"))
        return imageView
    }()
    
    fileprivate lazy var nickNameLabel:UILabel = {
        let label = UILabel()
        label.text = "快马学车"
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.sizeToFit()
        label.textColor = UIColor.lightGray
        
        return label
    }()
    
    fileprivate lazy var bgTitleLabel:UILabel = {
        let label = UILabel ()
        label.text = "快马学车"
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.sizeToFit()
        label.textColor = UIColor.white
        return label
    }()
    
    fileprivate lazy var onlineNumBtn:UIButton  = {
        let button = UIButton()
        button.setTitle( "666在线", for: .normal)
        button.setImage(UIImage(named:"Image_online"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
}


extension KMRecommandNormalCell{
    fileprivate func setupUI(){
        
        // 1
        addSubview(bgImageView)
        addSubview(vedioIconView)
        addSubview(nickNameLabel)
        addSubview(bgTitleLabel)
        addSubview(onlineNumBtn)
        
        // 2
        _ = bgImageView.xmg_Fill(referView: self, insets: UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0))
        
        _ = vedioIconView.xmg_AlignVertical(type: .BottomLeft, referView: bgImageView, size: nil,offset:CGPoint(x: 0, y: 5))
        _ = nickNameLabel.xmg_AlignHorizontal(type: .CenterRight, referView: vedioIconView, size: nil,offset:CGPoint(x: 10, y: 0))
        _ = bgTitleLabel.xmg_AlignVertical(type: .TopLeft, referView: vedioIconView, size: nil,offset:CGPoint(x: 5, y: -10))
        _ = onlineNumBtn.xmg_AlignVertical(type: .BottomRight, referView: bgImageView, size: nil,offset:CGPoint(x: -5, y: -23))
    }
}




