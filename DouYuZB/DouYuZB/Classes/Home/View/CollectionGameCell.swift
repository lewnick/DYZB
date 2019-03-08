//
//  CollectionGameCell.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/8.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //定义模型属性
    var group : AnchorGroup?{
        didSet{
            //image下面的Label 一定要添加高度固定值
            //image最好有上下约束
            titleLabel.text = group?.tag_name
            imageview.kf.setImage(with: URL(string: group?.icon_url ?? ""), placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    


}
