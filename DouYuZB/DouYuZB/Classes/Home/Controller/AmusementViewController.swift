//
//  AmusementViewController.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/21.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit

private let kamuseMenuH : CGFloat = 200

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyID = "kPrettyID"

class AmusementViewController: UIViewController {
    
    fileprivate lazy var amuseMenuView : AmusementMenuView = {
        let amusemenuView = AmusementMenuView.amusementMenuView()
        amusemenuView.frame = CGRect(x: 0, y: -kamuseMenuH, width: kScreenW, height: kamuseMenuH)
        return amusemenuView
    }()
    fileprivate lazy var amusementVM : AmusementViewModel = AmusementViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        //1.创建布局layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        
        
        //2.创建UIcollectionview
        
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.contentInset = UIEdgeInsets(top: kamuseMenuH, left: 0, bottom: 0, right: 0)
        
        
        return(collectionView)
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadAmusementData()
    }
    
}

extension AmusementViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        
        collectionView.addSubview(amuseMenuView)
        
        
    }
}

extension AmusementViewController{
    fileprivate func loadAmusementData(){
        self.amusementVM.loadAmusementData {
            
            self.collectionView.reloadData()
            var grouptemp = self.amusementVM.anchorGroupAmusemetGroup
            grouptemp.removeFirst()
            
            self.amuseMenuView.Groups = grouptemp
        }
    }
}


extension AmusementViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amusementVM.anchorGroupAmusemetGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amusementVM.anchorGroupAmusemetGroup[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = amusementVM.anchorGroupAmusemetGroup[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerview.group = amusementVM.anchorGroupAmusemetGroup[indexPath.section]
        return headerview
    }
}
