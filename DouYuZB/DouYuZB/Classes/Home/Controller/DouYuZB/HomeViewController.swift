//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by NicGe on 2018/8/24.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    //懒加载属性
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = (self as! PageTitleViewDelegate)
        
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)

        var childrenVcs = [UIViewController]()
        for _ in 0..<4
        {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r : CGFloat(arc4random_uniform(255)), g : CGFloat(arc4random_uniform(255)), b : CGFloat(arc4random_uniform(255)))
            childrenVcs.append(vc)
        }
        
        let contentview = PageContentView(frame: contentFrame, childVcs: childrenVcs, parentController: self)
        contentview.delegate = (self as! PageContentViewDelegate)
        
        return contentview
    }()
    
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        SetupUI()
        
    }
    
}
//设置UI界面
extension HomeViewController{
    
    private func SetupUI(){
        //0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        SetupNavigationTapbar()
        
        //2.添加TitleView
        view.addSubview(pageTitleView)
        
        //3.添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func SetupNavigationTapbar(){
        //1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalName: "logo")
        //2.设置右侧的Item
        let sized = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(normalName: "image_my_history", highlightedName: "Image_my_history_click", Size: sized)
        let searchItem = UIBarButtonItem(normalName: "btn_search", highlightedName: "btn_search_clicked", Size: sized)
        let qrcodeItem = UIBarButtonItem(normalName: "Image_scan", highlightedName: "Image_scan_click", Size: sized)        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

//遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}




