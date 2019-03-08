//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/4.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyID = "kPrettyID"

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: UIViewController {
    

    //懒加载属性
    private lazy var recommendVM : RecomandViewModel = RecomandViewModel()
    private lazy var collectionView : UICollectionView = {[weak self] in
    
        //1.创建布局layout
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
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
        
        
        return(collectionView)
    }()
    
    private lazy var cycleView : RecommendCycleView = {
        //通过Xib来创建必须调用类方法！！  所以必须使用快速创建类方法
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        //设置UI界面
        setupUI()
        
        //发送网络请求
        loadData()
        
        
        
        
    }

}
//设置UI界面内容
extension RecommendViewController{
    private func setupUI(){
        //1.将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        
        //2.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        //3.将GameView添加到UICollectionView中
        collectionView.addSubview(gameView)
        
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension RecommendViewController{
    private func loadData(){
        //1.请求推荐数据
        recommendVM.requestData {
            //1.
            self.collectionView.reloadData()
            //2.
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    
        
    }
}

//遵守uicollectionview数据源协议
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //1.定义cell
        var cell : CollectionBaseCell
        
        //2.取出cell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath) as! CollectionPrettyCell
           
            
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            
            
        }
        cell.anchor = anchor
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.取出模型数据
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
        
    }
    
}



