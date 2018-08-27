//
//  PageContentView.swift
//  DouYuZB
//
//  Created by NicGe on 2018/8/27.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //定义属性
    private var childVcs: [UIViewController]
    private var parentController: UIViewController
    
    //懒加载属性
    private lazy var collectionView : UICollectionView = {
        //1.创建Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentController: UIViewController) {
        self.childVcs = childVcs
        self.parentController = parentController
            
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

//设置UI界面
extension PageContentView {
    private func setupUI(){
        //1.将所有子控制器添加到父控制器中
        for childVc in childVcs{
            parentController.addChildViewController(childVc)
        }
        //2.添加UICollectionView,用于子Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
}

//遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //2.给Cell设置内容
        for view in cell.contentView.subviews
        {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}










