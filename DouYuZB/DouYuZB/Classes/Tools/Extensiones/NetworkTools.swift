//
//  NetworkTools.swift
//  AlamofireTEST
//
//  Created by NicGe on 2018/9/9.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import UIKit
import Alamofire

enum methodType {
    case GET
    case POST
}

class NetworkTools {
    
    class func requestData(type : methodType, URLString : String, parameters : [String:NSString]? = nil, finishedCallback : @escaping (_ result : AnyObject) ->()){
        
        //1.获取类型
        
        if type == .GET
        {
            //2.发送网络请求
            Alamofire.request(URLString, method: .get, parameters: parameters).responseJSON
            { (response) in
                //获取结果
                guard let result = response.result.value else{
                    print(response.result.error!)
                    return
                }
                //将结果回调出去
                finishedCallback(result as AnyObject)
            }
        }
        if type == .POST
        {
            
            Alamofire.request(URLString, method: .post, parameters: parameters).responseJSON
                { (response) in
                    
                    guard let result = response.result.value else{
                    print(response.result.error!)
                    return
                    }
                    finishedCallback(result as AnyObject)
                }
        }
        
    }
    
}
