//
//  ArgoUser.swift
//  App
//
//  Created by laijihua on 16/2/23.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation
import Argo
import Curry


/**
 *  Test Model
 */
struct ArgoUser {
    let id: Int
    let name: String
}


//extension ArgoUser: UserType {} // 给 view提供数据

extension ArgoUser: Decodable {
    static func decode(json: JSON) -> Decoded<ArgoUser> {
        return curry(ArgoUser.init)
            <^> json <| "id"
            <*> json <| "name"
    }
}
