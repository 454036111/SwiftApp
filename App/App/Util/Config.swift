//
//  Config.swift
//  App
//
//  Created by laijihua on 16/3/17.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation

import SwiftyBeaver


 /// log system
let log = SwiftyBeaver.self

func debugLog<T>(x: T, filename: String = __FILE__, line: Int = __LINE__, fn: String = __FUNCTION__) {
    log.verbose(x, filename, fn, line: line)
}


