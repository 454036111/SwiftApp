//
//  NetworkRouterGithub.swift
//  App
//
//  Created by laijihua on 16/2/23.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation
import Moya

extension NetworkRouter.GitHub: TargetType {
    
    var baseURL: NSURL { return NSURL(string: NetworkRouter.baseURLString)! }
    var path: String {
        switch self {
        case .Zen:
            return "/zen"
        case .UserProfile(let name):
            return "/user/\(name.URLEscapedString)"
        case .UserRepositories(let name):
            return "/users/\(name.URLEscapedString)/repos"
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .UserRepositories(_):
            return ["sort":"pushed"]
        default:
            return nil
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .Zen:
            return "Half measures are as bad as nothing at all.".dataUsingEncoding(NSUTF8StringEncoding)!
        case .UserProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".dataUsingEncoding(NSUTF8StringEncoding)!
        case .UserRepositories(_):
            return "[{\"name\": \"Repo Name\", \"id\": 100}]".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    static let Provider = RxMoyaProvider<NetworkRouter.GitHub>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
    
    
    
    

/*  ---- xcode crash
    let endpointClosure = { (target: NetworkRouter.GitHub) -> Endpoint<NetworkRouter.GitHub> in
        return Moya.Endpoint<NetworkRouter.GitHub>(URL: url(target),
                            sampleResponseClosure: {.NetworkResponse(200, target.sampleData)},
                                           method: target.method,
                                       parameters: target.parameters)
        
    }
    
    let failureEndpointClosure = { (target: NetworkRouter.GitHub) -> Endpoint<NetworkRouter.GitHub> in
        let sampleResponseClosure = { () -> (EndpointSampleResponse) in
            if shouldTimeout {
                return .NetworkError(NSError())
            } else {
                return .NetworkResponse(200, target.sampleData)
            }
        }
        return Moya.Endpoint<NetworkRouter.GitHub>(URL: url(target),
                            sampleResponseClosure: sampleResponseClosure,
                                           method: target.method,
                                       parameters: target.parameters)
    }
*/
    

}
