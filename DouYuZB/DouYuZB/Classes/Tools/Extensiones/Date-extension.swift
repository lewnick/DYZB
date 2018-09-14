//
//  NSDate-extension.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/9.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowData = Date()
        let interval = Int(nowData.timeIntervalSince1970)
        
        return "\(interval)"
    
        
    }
}

