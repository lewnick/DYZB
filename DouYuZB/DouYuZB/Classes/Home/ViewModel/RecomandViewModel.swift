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
    //0 1 2-12
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

//发送网络请求
extension RecomandViewModel{
    //请求推荐数据
    func requestData(finishCallback : @escaping () -> () ){
        //0.
        let dgroup = DispatchGroup()
        
        
        //1.请求第一部分推荐数据
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1536885573
        dgroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":Date.getCurrentTime() as NSString]) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //2.根据key,也就是data，获取value,数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //3.遍历字典，并且转成模型对象
            //3.1创建组
           
            //3.2设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.small_icon_url = "home_header_hot"
            //3.3获取主播数据
            for dict in dataArray{
                self.bigDataGroup.anchors.append(AnchorModel(dict: dict))
            }
            dgroup.leave()
            
        }
        
        
        //2.请求第二部分颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1536885573
        dgroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: ["limit":"4","offset":"0","time" : Date.getCurrentTime() as NSString]) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //2.根据key,也就是data，获取value,数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //3.遍历字典，并且转成模型对象
            //3.1创建组
          
            //3.2设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.small_icon_url = "home_header_normal"
            //3.3获取主播数据
            for dict in dataArray{
                self.prettyGroup.anchors.append(AnchorModel(dict: dict))
            }
            dgroup.leave()
            
        }
        
        
        //3.请求后面部分的游戏数据
        //1536497491
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1536885573
        //print(Date.getCurrentTime() as NSString)
        dgroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time" : Date.getCurrentTime() as NSString]) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.遍历数组，获取字典，并且将字典转成模型对象
            
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
                print(dict["tag_name"]!)
                print(dict["small_icon_url"]!)
            }
            
            dgroup.leave()
            
        }
        
        //4.所有的数据都请求到，之后进行排序
        dgroup.notify(queue: DispatchQueue.main) {
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
        
        
    }
    //请求无限轮播数据
    func requestCycleDate(finishCallback : @escaping () -> () ) {
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else {return}
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3.字典转模型对象
            for dict in dataArray
            {
                self.cycleModels.append(CycleModel(dict: dict))
                
            }
            
            //  www.douyutv.com/api/v1/slide/6?version=2.300
            finishCallback()
        }
    }
    
}
























