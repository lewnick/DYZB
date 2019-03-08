//
//  CycleModel.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/7.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit
//自定义构造函数的属性 记得以@objc 开头
class CycleModel: NSObject {

    //标题
    @objc var title : String = ""
    //图片
    @objc var pic_url : String = ""
    //房间主播信息
    @objc var room : [String:NSObject]?{
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    //主播模型
    @objc var anchor : AnchorModel?
    
    //自定义构造函数
    init(dict : [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
