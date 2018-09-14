//
//  RecomandViewModel.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/9.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit

class RecomandViewModel {
    //懒加载属性
    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
}

//发送网络请求
extension RecomandViewModel{
    func requestData(){
        //1.请求第一部分推荐数据
        
        //2.请求第二部分颜值数据
        
        //3.请求后面部分的游戏数据
        //1536497491
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1536885573
//        print(Date.getCurrentTime() as NSString)
        
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time" : Date.getCurrentTime() as NSString]) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //3.遍历数组，获取字典，并且将字典转成模型对象
            
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            for group in self.anchorGroups{
                for anchor in group.anchors{
                    print(anchor.nickname)
                }
                
                print("----------")
            }
            
        }
    }
}























