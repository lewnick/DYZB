//
//  GameViewController.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/18.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kGameCellID : String = "kGameCellID"

class GameViewController: UIViewController {

    //懒加载collectionview
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        let collectionVIew = UICollectionView(frame: self.view.bounds , collectionViewLayout: layout)
        collectionVIew.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionVIew.dataSource = self
        
        return  collectionVIew
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        view.backgroundColor = UIColor.purple
    }
    
}

extension GameViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
}

extension GameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    

    
}
