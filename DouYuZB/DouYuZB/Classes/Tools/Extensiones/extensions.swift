//
//  extensions.swift
//  DouYuZB
//
//  Created by NicGe on 2018/8/24.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
  /*  class func creatItem(normalName : String, highlightedName : String, Size : CGSize) -> UIBarButtonItem
    {
        let Btn = UIButton()
        Btn.setImage(UIImage(named: normalName), for: .normal)
        Btn.setImage(UIImage(named: highlightedName), for: .highlighted)
        Btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: Size)
        return UIBarButtonItem(customView: Btn)
    }  */
    
    convenience init(normalName : String, highlightedName : String = "", Size : CGSize = CGSize(width: 0, height: 0)) {
        let Btn = UIButton()
        Btn.setImage(UIImage(named: normalName), for: .normal)
        if highlightedName != ""
        {
            Btn.setImage(UIImage(named: highlightedName), for: .highlighted)
        }
        if Size != CGSize(width: 0, height: 0)
        {
            Btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: Size)
        }else
        {
            Btn.sizeToFit()
        }
        self.init(customView: Btn)
    }
}
