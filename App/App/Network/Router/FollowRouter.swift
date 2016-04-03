//
//  FollowRouter.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Moya

extension Router.Follow : RouterProtocol {
    var method: HTTPMethod {
        return .GET
    }
    
    var encoding: HTTPEncoding {
        return .URL
    }
    
    var configuration: Configuration {
        switch self {
        case .ReadAuthenticatedFollowers(let config): return config
        case .ReadFollowers(_, let config): return config
        case .ReadAuthenticatedFollowing(let config): return config
        case .ReadFollowing(_, let config): return config
        }
    }
    
    var path: String {
        switch self {
        case .ReadAuthenticatedFollowers:
            return "user/followers"
        case .ReadFollowers(let username, _):
            return "users/\(username)/followers"
        case .ReadAuthenticatedFollowing:
            return "user/following"
        case .ReadFollowing(let username, _):
            return "users/\(username)/following"
        }
    }
    
    var parameters: [String: AnyObject]? {
        var parame = [String:String]()
        if let accessToken = configuration.accessToken {
            parame[configuration.accessTokenFieldName] = accessToken
        }
        return parame
    }
    
    var baseURL: NSURL {
        return NSURL(string: Router.githubBaseURL)!
    }
    
    var provider: RxMoyaProvider<Router.Follow> {
        return RxMoyaProvider<Router.Follow>()
    }
    
}
