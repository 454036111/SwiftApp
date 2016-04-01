//
//  UserRouter.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Moya

extension Router.User: RouterProtocol {
    var configuration: Configuration {
        switch self {
        case .ReadAuthenticatedUser(let config): return config
        case .ReadUser(_, let config): return config
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var encoding: HTTPEncoding {
        return .URL
    }
    
    var path: String {
        switch self {
        case .ReadAuthenticatedUser:
            return "user"
        case .ReadUser(let username, _):
            return "users/\(username)"
        }
    }
    
    var parameters: [String: AnyObject]? {
        return [:]
    }
    
    var baseURL: NSURL {
        return NSURL(string: Router.githubWebURL)!
    }
    
    var provider: RxMoyaProvider<Router.User> {
        let endpointClosure = { (target: Router.User) -> Endpoint<Router.User> in
            let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
            return Endpoint(URL: url, sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.encoding)
        }
        return RxMoyaProvider<Router.User>(endpointClosure: endpointClosure)
    }
}