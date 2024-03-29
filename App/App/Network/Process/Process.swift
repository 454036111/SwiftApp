//
//  NetworkProcess.swift
//  App
//
//  Created by laijihua on 16/2/23.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation
import Argo
import Moya
import RxSwift


public typealias Github = Process


// 待留扩展用
public struct Process {
    typealias ErrorHandle = ErrorType -> ()
    let disposeBag = DisposeBag()
    public let configuration: TokenConfiguration
    
    public init (_ config: TokenConfiguration = TokenConfiguration()) {
        configuration = config
    }
}