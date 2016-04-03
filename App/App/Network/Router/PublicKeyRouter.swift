//
//  PublicKeyRouter.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Moya

extension Router.PublicKey: RouterProtocol {
    
    var method: HTTPMethod {
        switch self {
        case .PostPublicKey:
            return .POST
        }
    }
    
    var encoding: HTTPEncoding {
        switch self {
        case .PostPublicKey:
            return .JSON
        }
    }
    
    var configuration: Configuration {
        switch self {
        case .PostPublicKey(_, _, let config): return config
        }
    }
    
    var path: String {
        switch self {
        case .PostPublicKey:
            return "user/keys"
        }
    }

    
    var parameters: [String: AnyObject]? {
        switch self {
        case .PostPublicKey(let publicKey, let title, _):
            return ["title": title, "key": publicKey]
        }
    }
    
    var baseURL: NSURL {
        return NSURL(string: Router.githubBaseURL)!
    }
    
    var provider: RxMoyaProvider<Router.PublicKey> {
        let endpointClosure = { (target: Router.PublicKey) -> Endpoint<Router.PublicKey> in
            let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
            return Endpoint(URL: url, sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.encoding)
        }
        return RxMoyaProvider<Router.PublicKey>(endpointClosure: endpointClosure)
    }
    
}