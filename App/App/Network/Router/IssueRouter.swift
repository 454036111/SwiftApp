//
//  IssueRouter.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Moya

extension Router.Issue: RouterProtocol {
    
    var method: HTTPMethod {
        switch self {
        case .PostIssue, .PatchIssue:
            return .POST
        default:
            return .GET
        }
    }
    
    var encoding: HTTPEncoding {
        switch self {
        case .PostIssue, .PatchIssue:
            return .JSON
        default:
            return .URL
        }
    }
    
    var configuration: Configuration {
        switch self {
        case .ReadAuthenticatedIssues(let config, _, _): return config
        case .ReadIssue(let config, _, _, _): return config
        case .PostIssue(let config, _, _, _, _, _): return config
        case .PatchIssue(let config, _, _, _, _, _, _, _): return config
        }
    }
    
    var path: String {
        switch self {
        case .ReadAuthenticatedIssues:
            return "issues"
        case .ReadIssue(_, let owner, let repository, let number):
            return "repos/\(owner)/\(repository)/issues/\(number)"
        case .PostIssue(_, let owner, let repository, _, _, _):
            return "repos/\(owner)/\(repository)/issues"
        case .PatchIssue(_, let owner, let repository, let number, _, _, _, _):
            return "repos/\(owner)/\(repository)/issues/\(number)"
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .ReadAuthenticatedIssues(_, let page, let perPage):
            return ["per_page": perPage, "page": page]
        case .ReadIssue:
            return [:]
        case .PostIssue(_, _, _, let title, let body, let assignee):
            var params = ["title": title]
            if let body = body {
                params["body"] = body
            }
            if let assignee = assignee {
                params["assignee"] = assignee
            }
            return params
        case .PatchIssue(_, _, _, _, let title, let body, let assignee, let state):
            var params: [String: String] = [:]
            if let title = title {
                params["title"] = title
            }
            if let body = body {
                params["body"] = body
            }
            if let assignee = assignee {
                params["assignee"] = assignee
            }
            if let state = state {
                params["state"] = state.rawValue
            }
            return params
        }
    }
    
    var baseURL: NSURL {
        return NSURL(string: Router.githubWebURL)!
    }
    
    var provider: RxMoyaProvider<Router.Issue> {
        let endpointClosure = { (target: Router.Issue) -> Endpoint<Router.Issue> in
            let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
            return Endpoint(URL: url, sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.encoding)
        }
        return RxMoyaProvider<Router.Issue>(endpointClosure: endpointClosure)
    }
    
    
}

