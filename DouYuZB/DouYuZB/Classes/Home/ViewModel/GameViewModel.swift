//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by NicGe on 2019/3/20.
//  Copyright © 2019 NicGe. All rights reserved.
//

import UIKit

class GameViewModel{

}

extension GameViewModel{
    func loadData(finishedCallback : () -> ()){
        //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
        //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) in
            
        }
    }
}
