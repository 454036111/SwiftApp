//
//  RepositoryRouter.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Moya
extension Router.Repository : RouterProtocol {
    var configuration: Configuration {
        switch self {
        case .ReadRepositories(let config, _, _, _): return config
        case .ReadAuthenticatedRepositories(let config, _, _): return config
        case .ReadRepository(let config, _, _): return config
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var encoding: HTTPEncoding {
        return .URL
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .ReadRepositories(_, _, let page, let perPage):
            return ["per_page": perPage, "page": page]
        case .ReadAuthenticatedRepositories(_, let page, let perPage):
            return ["per_page": perPage, "page": page]
        case .ReadRepository:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case ReadRepositories(_, let owner, _, _):
            return "/users/\(owner)/repos"
        case .ReadAuthenticatedRepositories:
            return "/user/repos"
        case .ReadRepository(_, let owner, let name):
            return "/repos/\(owner)/\(name)"
        }
    }
    
    var baseURL: NSURL {
        return NSURL(string: Router.githubBaseURL)!
    }
    
    var provider: RxMoyaProvider<Router.Repository> {
        let endpointClosure = { (target: Router.Repository) -> Endpoint<Router.Repository> in
            let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
            return Endpoint(URL: url, sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.encoding)
        }
        return RxMoyaProvider<Router.Repository>(endpointClosure: endpointClosure)
    }
}
