//
//  CollectionBaseCell.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/17.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    
    //控件属性
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel?{
        didSet{
            //0.校验模型是否有值
            guard let anchor = anchor else {return}
            //1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000{
                onlineStr = "\(Int(anchor.online / 10000)).\(Int(anchor.online / 1000) - ( Int(anchor.online / 10000) * 10 ))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //2.昵称的显示
            nickNameLabel.text = anchor.nickname
    
            //4.设置封面图片
            iconImageView.kf.setImage(with: URL(string: anchor.vertical_src))
        }
    }
}
