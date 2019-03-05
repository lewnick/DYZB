//
//  PageContentView.swift
//  DouYuZB
//
//  Created by NicGe on 2018/8/27.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int , targetIndex : Int)
}

class PageContentView: UIView {

    //定义属性
    private var childVcs: [UIViewController]
    private weak var parentController: UIViewController?
    private var startOffsetX : CGFloat = 0
    private var isForbinScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    //懒加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        collectionView.delegate = self
        
        return collectionView
    }()
    
    //自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentController: UIViewController?) {
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
            parentController?.addChild(childVc)
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

extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbinScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0.判断是否是点击事件
        if isForbinScrollDelegate == true {return}
        
        //1.获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        let currentoffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentoffsetX > startOffsetX { //左滑
            //1.计算progress
            progress = currentoffsetX / scrollViewW - floor(currentoffsetX / scrollViewW)
            //2.计算sourceIndex
            sourceIndex = Int(currentoffsetX / scrollViewW)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //4.如果完全滑过去
            if currentoffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //1.计算progress
            progress = 1 - (currentoffsetX / scrollViewW - floor(currentoffsetX / scrollViewW))
            targetIndex = Int(currentoffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if targetIndex < 0{
                targetIndex = 0
            }
//            4.如果完全滑过去
            if startOffsetX  - currentoffsetX == scrollViewW{
                progress = 1
                sourceIndex = targetIndex
            }
        }
        
        
        //3.将progress/sourceIndex/targetIndex传递给titleView
//        print("progress:\(progress)sourceIndex:\(sourceIndex)targetIndex:\(targetIndex)")
        
        //4.通知代理
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//对外暴露的方法
extension PageContentView {
    
    func setCurrentIndex(currentIndex : Int) {
        //1.记录需要进行执行代理方法
        isForbinScrollDelegate = true
        //2.实现滚动行为
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}








