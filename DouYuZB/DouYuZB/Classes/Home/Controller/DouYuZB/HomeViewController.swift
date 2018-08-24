//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by NicGe on 2018/8/24.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SetupUI()
        
    }
    


}

extension HomeViewController{
    
    private func SetupUI(){
        SetupNavigationTapbar()
        
    }
    
    private func SetupNavigationTapbar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalName: "logo")
        let sized = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(normalName: "image_my_history", highlightedName: "Image_my_history_click", Size: sized)
        let searchItem = UIBarButtonItem(normalName: "btn_search", highlightedName: "btn_search_clicked", Size: sized)
        let qrcodeItem = UIBarButtonItem(normalName: "Image_scan", highlightedName: "Image_scan_click", Size: sized)        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}
