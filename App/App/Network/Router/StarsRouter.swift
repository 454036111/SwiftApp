//
//  StarsRouter.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Moya

extension Router.Stars: RouterProtocol {
    var method: HTTPMethod {
        return .GET
    }

    var configuration: Configuration {
        switch self {
        case .ReadAuthenticatedStars(let config): return config
        case .ReadStars(_, let config): return config
        }
    }
    
    var encoding: HTTPEncoding {
        return .URL
    }
    
    var path: String {
        switch self {
        case .ReadAuthenticatedStars:
            return "user/starred"
        case .ReadStars(let username, _):
            return "users/\(username)/starred"
        }
    }
    
    var parameters: [String: AnyObject]? {
        return [:]
    }
    
    
    var baseURL: NSURL {
        return NSURL(string: Router.githubBaseURL)!
    }
    
    var provider: RxMoyaProvider<Router.Stars> {
        let endpointClosure = { (target: Router.Stars) -> Endpoint<Router.Stars> in
            let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
            return Endpoint(URL: url, sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.encoding)
        }
        return RxMoyaProvider<Router.Stars>(endpointClosure: endpointClosure)
    }
}
