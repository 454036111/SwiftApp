//
//  MutableBox.swift
//  App
//
//  Created by laijihua on 16/3/17.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation

public final class MutableBox<T>: MutableBoxType, CustomStringConvertible {
    /// Initializes a `MutableBox` with the given value.
    public init(_ value: T) {
        self.value = value
    }
    
    /// The (mutable) value wrapped by the receiver.
    public var value: T
    
    /// Constructs a new MutableBox by transforming `value` by `f`.
    public func map<U>(f: T -> U) -> MutableBox<U> {
        return MutableBox<U>(f(value))
    }
    
    // MARK: Printable
    
    public var description: String {
        return String(value)
    }
}
