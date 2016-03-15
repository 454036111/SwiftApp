//
//  ResourceProvider.swift
//  App
//
//  Created by laijihua on 16/3/15.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation

class ResourceProvider {
    struct Color {}
    struct Font {}
    let color = Color()
    let font = Font()
}



extension ResourceProvider {
    // MARK: 单利，getmethod
    static var shareInstance: ResourceProvider {
        struct Singleton {
            static let instance = ResourceProvider()
        }
        return Singleton.instance
    }
}
