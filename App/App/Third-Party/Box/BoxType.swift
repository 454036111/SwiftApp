//
//  BoxType.swift
//  App
//
//  Created by laijihua on 16/3/17.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation

public protocol BoxType {
    
    typealias Value
    
    init (_ value: Value)
    
    var value: Value { get }
}


public protocol MutableBoxType: BoxType {
    var value: Value { get set }
}



public func == <B: BoxType where B.Value: Equatable>(lhs: B, rhs: B) -> Bool {
    return lhs.value == rhs.value
}

public func != <B: BoxType where B.Value: Equatable>(lhs: B, rhs: B) -> Bool {
    return lhs.value != rhs.value
}


// MARK: Map
/// Maps the value of a box into a new box.
public func map<B: BoxType, C: BoxType> (v: B, f: B.Value -> C.Value) -> C {
    return C(f(v.value))
}























