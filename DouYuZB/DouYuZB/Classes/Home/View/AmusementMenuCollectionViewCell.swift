//
//  AmusementMenuCollectionViewCell.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/21.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit

private let kAmuseGamecellID = "kAmuseGamecellID"

class AmusementMenuCollectionViewCell: UICollectionViewCell {
    
    var GroupsinCell : [AnchorGroup]?{
        didSet{
            self.collectionview.reloadData()
        }
    }

    @IBOutlet weak var collectionview: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kAmuseGamecellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        let cellW = collectionview.bounds.width / 4
        let cellH = collectionview.bounds.height / 2
        layout.itemSize = CGSize(width: cellW, height: cellH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
}

extension AmusementMenuCollectionViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GroupsinCell?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseGamecellID, for: indexPath) as! CollectionGameCell
        cell.group = GroupsinCell![indexPath.item]
//                cell.clipsToBounds = false
        return cell
    }
    
    
    
}
