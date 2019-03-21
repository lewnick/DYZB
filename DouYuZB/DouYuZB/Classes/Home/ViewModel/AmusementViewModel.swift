//
//  AmusementViewModel.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/21.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit

class AmusementViewModel {
    lazy var anchorGroupAmusemetGroup : [AnchorGroup] = [AnchorGroup]()
}

extension AmusementViewModel{
    func loadAmusementData(finishCallback : @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            guard let resultDict = result as? [String : NSObject] else{return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{return}
            
            for dict in dataArray{
                self.anchorGroupAmusemetGroup.append(AnchorGroup(dict: dict))
            }
            
            finishCallback()
        }
    }
}
