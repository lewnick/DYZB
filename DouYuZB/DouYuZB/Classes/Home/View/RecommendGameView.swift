//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/7.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit

private let kGameViewID = "kGameViewID"
private let kContentInsetMagin : CGFloat = 8

class RecommendGameView: UIView {
    
    //
    var groups : [AnchorGroup]?{
        didSet{
            //移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            //添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            //刷新表格
            self.collectionView.reloadData()
        }
    }
    //
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        
        //让控件不随着父控件的拉伸而拉伸autoresizingMask = [.]
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameViewID)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kContentInsetMagin, bottom: 0, right: kContentInsetMagin)
        
    }
    

}
//快速创建类方法
extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewID, for: indexPath) as! CollectionGameCell
        
        cell.group = groups?[indexPath.item]
        
        return cell
    }
    
    
}
