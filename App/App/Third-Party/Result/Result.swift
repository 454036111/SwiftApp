//
//  Result.swift
//  App
//
//  Created by laijihua on 16/3/17.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation
// import Box

public enum Maybe<T> {
    
    case Failure(MaybeErrorType)
    
    case Success(Box<T>)
    
    public init(failure: MaybeErrorType) {
        self = .Failure(failure)
    }
    
    public init(sucess: T) {
        self = .Success(Box(sucess))
    }
    
    
    public var successValue: T? {
        switch self {
        case let .Success(success): return success.value
        case .Failure: return nil
        }
    }
    
    public var failureValue: MaybeErrorType? {
        switch self {
        case .Success: return nil
        case let .Failure(error): return error
        }
    }

    
    public var isSuccess: Bool {
        switch self {
        case .Success: return true
        case .Failure: return false
        }
    }
    
    public var isFailure: Bool {
        switch self {
        case .Success: return false
        case .Failure: return true
        }
    }
    
    public func map<U> (f: T -> U) -> Maybe<U> {
        switch self {
        case let .Failure(error): return .Failure(error)
        case let .Success(value): return .Success(Box(f(value.value)))
        }
    }

    public func bind<U>(f: T -> Maybe<U>) -> Maybe<U> {
        switch self {
        case let .Failure(error): return .Failure(error)
        case let .Success(value): return f(value.value)
        }
    }
}

extension Maybe: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .Failure(error): return "Result.Failure(\(error))"
        case let .Success(value): return "Result.Success(\(value.value))"
        }
    }
}



