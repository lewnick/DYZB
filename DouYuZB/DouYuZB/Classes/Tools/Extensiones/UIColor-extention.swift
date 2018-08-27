//
//  UIColor-extention.swift
//  DouYuZB
//
//  Created by NicGe on 2018/8/26.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
