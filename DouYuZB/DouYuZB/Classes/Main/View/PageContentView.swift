//
//  PageContentView.swift
//  DouYuZB
//
//  Created by NicGe on 2018/8/27.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

class PageContentView: UIView {

    //定义属性
    private var childVcs: [UIViewController]
    private var parentController: UIViewController
    
    //自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentController: UIViewController) {
        self.childVcs = childVcs
        self.parentController = parentController
            
        super.init(frame: frame)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
        
        
   

}
