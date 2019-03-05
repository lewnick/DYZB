//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/4.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageVIew: UIImageView!
    
    //定义模型属性
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            if (group?.small_icon_url == nil){
                iconImageVIew.image = UIImage(named: "home_header_hot")
            }else{
            
                let abc : urlWebString2UIImage = urlWebString2UIImage()
                iconImageVIew.image = abc.loadWebImage(urlString: (group?.small_icon_url)!)
                    
          
            }
          
            
        }
    }
    
}


