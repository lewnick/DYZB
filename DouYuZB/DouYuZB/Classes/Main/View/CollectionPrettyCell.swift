//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/6.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    //控件属性

    @IBOutlet weak var cityBtn: UIButton!
    
    //定义模型属性
    override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            //所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)

        }
    }
    
}
