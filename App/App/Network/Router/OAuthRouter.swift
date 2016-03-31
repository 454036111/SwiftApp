//
//  OAuthRouter.swift
//  App
//
//  Created by laijihua on 3/30/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Moya

extension Router.OAuth: RouterProtocol {
    
    var configuration: Configuration {
        switch self {
        case .Authorize(let config): return config
        case .AccessToken(let config , _): return config
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .Authorize: return .GET
        case .AccessToken: return .POST
        }
    }
    
    var encoding: HTTPEncoding {
        switch self {
        case .Authorize:
            return .URL
        case .AccessToken:
            return .URL
        }
    }

    var baseURL: NSURL {
        var urlstr = EmptyString
        switch self {
        case .Authorize(let config):
            urlstr = config.webEndpoint
        case .AccessToken(let config, _):
            urlstr = config.webEndpoint
        }
        return NSURL(string: urlstr)!
    }
    
    var path: String {
        switch self {
        case .Authorize:
            return "login/oauth/authorize"
        case .AccessToken:
            return "login/oauth/access_token"
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .Authorize(let config):
            let scope = (config.scopes as NSArray).componentsJoinedByString(",")
            return ["scope": scope, "client_id": config.token]
        case .AccessToken(let config, let code):
            return ["client_id": config.token, "client_secret": config.secret, "code": code]
        }
    }
    
    var provider: RxMoyaProvider<Router.OAuth> {
        let endpointClosure = { (target: Router.OAuth) -> Endpoint<Router.OAuth> in
            let url = target.requestUrlStr()
            return Endpoint(URL: url, sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.encoding)
        }
        return RxMoyaProvider<Router.OAuth>(endpointClosure: endpointClosure)
    }
}

extension Router.OAuth {
    func requestUrlStr() -> String{
        return  baseURL.URLByAppendingPathComponent(path).absoluteString
    }
    
}




