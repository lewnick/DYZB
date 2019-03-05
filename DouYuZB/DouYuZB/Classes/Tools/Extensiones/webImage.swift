//
//  webImage.swift
//  DouYuZB
//
//  Created by NicGe on 2018/9/17.
//  Copyright © 2018年 NicGe. All rights reserved.
//

import Foundation
import UIKit

class urlWebString2UIImage {
    func loadWebImage(urlString : String) -> UIImage{
        var returnimage : UIImage = UIImage(named: "home_header_hot")!
        if let url = URL(string: urlString) {
            do{
                let data = try Data(contentsOf: url)
                returnimage = UIImage(data: data)!
            }catch _ {
//                print("ERROR : \(error.localizedDescription)")
            }
        }
        return returnimage
    }
}


/*
 @IBOutlet weak var uiimage: UIImageView!
 let imageurl : String = "https://dynaimage.cdn.cnn.com/cnn/q_auto,w_1421,c_fill,g_auto,h_799,ar_16:9/http%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F180316113418-travel-with-a-dog-3.jpg"
 
 @IBAction func click(_ sender: Any) {
    if let url = URL(string: imageurl) {
        do{
            let data = try Data(contentsOf: url)
            self.uiimage.image = UIImage(data: data)
        }catch let error {
            print("ERROR : \(error.localizedDescription)")
            }
        }
 
 }*/
