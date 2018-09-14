//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/14.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间ID
    @objc var room_id : Int = 0
    //房间图片对于的URLString
    @objc var vertical_src : String = ""
    //判断是手机直播还是电脑直播
    //0:电脑直播。1:手机直播
    @objc var isVertical : Int = 0
    //房间名称
    @objc var room_name : String = ""
    //主播昵称
    @objc var nickname : String = ""
    //观看人数
    @objc var online : Int = 0
    
    init(dict : [String:NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    
    
    
    
    
    
    
    
    
}
