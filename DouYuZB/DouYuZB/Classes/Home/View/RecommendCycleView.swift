//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/6.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit

private let CycleViewID = "CycleViewID"

class RecommendCycleView: UIView {
    
    //定义属性
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]?{
        didSet{
            //1.刷新collectionView
            self.collectionView.reloadData()
            //2.设置pagecontrol个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //3.默认滚动到中间某一个位置
            let indexpath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexpath, at: .left, animated: false)
            //4.添加定时器
            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    //控件属性
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //系统回调函数
    override func awakeFromNib() {
        ////设置该控件不随着父控件的拉伸而拉伸
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: CycleViewID)
        
        
        
    }
    // 在layoutSubviews 里面拿到的尺寸永远是正确的
    //当我们发现无论设置什么值都无法改变视图、图片等的大小和位置时，就尝试用layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews() //这句话必不可少！
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout //xib 没有直接的flowlayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.isPagingEnabled = true
    }
    
}

//提供一个快速创建View的类方法
extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as!RecommendCycleView
    }
}
//遵循UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleViewID, for: indexPath) as! CollectionViewCycleCell
        cell.cyclemodel = cycleModels?[indexPath.item % (cycleModels?.count)!]
        
        return cell
    }
}
//遵循UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x 
        //2.计算pagecontrol的 currentindex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//对定时器的操作方法
extension RecommendCycleView{
    private func addCycleTimer(){
        //注意#selector(self.function)里面的function没有带参数的（）
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        //定时器必须加到运行循环里面，最好加到 common模式
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    private func removeCycleTimer(){
        cycleTimer?.invalidate() //使定时器无效,从运行循环中移除
        cycleTimer = nil
    }
    
    @objc private func scrollToNext(){
        let currentOffsetX = collectionView.contentOffset.x
        let setOffsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: setOffsetX, y: 0), animated: true)
    }
}




