//
//  AmusementMenuView.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/21.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit

private let kAmuseMenuID = "kAmuseMenuID"

class AmusementMenuView: UIView {

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    var Groups : [AnchorGroup]?{
        didSet{
            self.collectionview.reloadData()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionview.register(UINib(nibName: "AmusementMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseMenuID)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func layoutSubviews() {
        let layout = collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionview.bounds.size
    }

}

extension AmusementMenuView{
    class func amusementMenuView() -> AmusementMenuView{
        return Bundle.main.loadNibNamed("AmusementMenuView", owner: nil, options: nil)?.first as! AmusementMenuView
    }
}

extension AmusementMenuView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Groups == nil {return 0}
        let pagercount = (Groups!.count - 1) / 8 + 1
        pagecontrol.numberOfPages = pagercount
        
        return pagercount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: kAmuseMenuID, for: indexPath) as! AmusementMenuCollectionViewCell
        setupCellDatawithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDatawithCell(cell: AmusementMenuCollectionViewCell, indexPath : IndexPath){
        //page0: 0~7
        //page1: 8~15
        //page2: 16~23
        //1.取出起始位置和终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        //2.判断越界问题
        if endIndex > Groups!.count - 1{
            endIndex = Groups!.count - 1
        }
        //3.取出数据，并且赋值给CELL
        cell.GroupsinCell = Array(Groups![startIndex...endIndex])

    }
}

extension AmusementMenuView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pagecontrol.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
