//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/5.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!

    override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            //设置房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
}
