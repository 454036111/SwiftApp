//
//  NetworkRouter.swift
//  App
//
//  Created by laijihua on 16/2/23.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation
import Moya


// Moya + RxSwift + Argo,  设计目标
//provider
//    .request(.AllUsers)
//    .mapArray(ArgoUser.self, rootKey: "users")
//    .observeOn(MainScheduler.instance)
//    .subscribeNext { users in
//        
//        self.users = users
//        self.tableView.reloadData()
//        
//    }.addDisposableTo(disposeBag)


func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

extension TargetType {
    var url:String {
        return self.baseURL.URLByAppendingPathComponent(self.path).absoluteString
    }
    
}




////////////////////////////////////////////////////////


/**
 *  接口路由类
 */
struct NetworkRouter {
    static let baseURLString = "https://api.github.com"
    
    // Test
    enum GitHub {
        case Zen
        case UserProfile(String)
        case UserRepositories(String)
    }
    
}




