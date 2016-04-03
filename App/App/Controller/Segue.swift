//
//  Segue.swift
//  App
//
//  Created by laijihua on 4/3/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation

struct Segue {
    enum Login: String { // 每个模块对应一个segue
        case LonginViewControllerSegue = "LonginViewControllerSegue"
    }
    
    enum Index: String {
        case LonginSegue  = "LoginSegue"
    }
    
}
