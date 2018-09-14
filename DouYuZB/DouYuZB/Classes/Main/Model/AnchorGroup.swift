//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/14.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //该组对应的房间信息
    @objc var room_list : [[String : NSObject]]?{
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的标题
    @objc var tag_name : String = "default"
    //组显示的图标
    @objc var small_icon_url : String = ""
    //定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    
    init(dict : [String : Any]) {
        super.init()
    
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list"{
//            guard let valueA = value as? [[String : NSObject]] else {return}
//            for list in valueA{
//                self.anchors.append(AnchorModel(dict: list))
//            }
//        }
//    }
}
