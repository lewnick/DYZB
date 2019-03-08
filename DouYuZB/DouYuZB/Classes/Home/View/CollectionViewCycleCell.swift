//
//  CollectionViewCycleCell.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/7.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCycleCell: UICollectionViewCell {
    
    //添加控件属性
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //定义模型属性
    var cyclemodel : CycleModel?{
        didSet{
            titleLabel.text = cyclemodel?.title
            imageView.kf.setImage(with: URL(string: cyclemodel?.pic_url ?? "Img_default"))
//            let imageurl : urlWebString2UIImage = urlWebString2UIImage()
//            imageView.image = imageurl.loadWebImage(urlString: cyclemodel?.pic_url ?? "Img_default")
            
        }
    }
    

}
