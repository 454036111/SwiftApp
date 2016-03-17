//
//  Box.swift
//  App
//
//  Created by laijihua on 16/3/17.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation

public final class Box<T>: BoxType, CustomStringConvertible {
    public init(_ value: T) {
        self.value = value
    }
    
    public class func unit(value: T) -> Box<T> {
        return Box(value)
    }
    
    public let value: T
    
    /// Constructs a new Box by transforming `value` by `f`.
    public func map<U> (f: T -> U) -> Box<U> {
        return Box<U>(f(value))
    }
    
    // MARK: Printable
    public var description: String {
        return String(value)
    }

}
