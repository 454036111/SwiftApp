//
//  NetworkRouterSearch.swift
//  App
//
//  Created by laijihua on 16/2/24.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation
import Moya

extension NetworkRouter.Search: TargetType {
    var baseURL: NSURL {
        return NSURL(string: NetworkRouter.baseURLString)!
    }
    
    var path: String {
        switch self{
        case .Repositories(let q , let sort, let order, let language):
            print((q, sort, order,language))
            return "/search/repositories"
        case .Code(let q , let sort, let order, let language):
            print((q, sort, order, language))
            return "/search/code"
        case .Users(let q , let sort, let order):
            print((q, sort, order))
            return "GET /search/users"
        case .Issues(let q , let sort, let order):
            print((q, sort, order))
            return "/search/issues"
        }
        
    }
    var method: Moya.Method { return .GET }
    var parameters: [String: AnyObject]? {
        switch self{
        case .Repositories(let q , let sort, let order, let language):
            return handleTupleToDict(q , language: language, sort: sort, order: order)
        case .Code(let q , let sort, let order, let language):
            return handleTupleToDict(q , language: language, sort: sort, order: order)
        case .Users(let q , let sort, let order):
           return handleTupleToDict(q , language: nil, sort: sort, order: order)
        case .Issues(let q , let sort, let order):
            return handleTupleToDict(q , language: nil, sort: sort, order: order)
        }
    }
    var sampleData: NSData { return "sort".dataUsingEncoding(NSUTF8StringEncoding)!  }
    static let Provider = RxMoyaProvider<NetworkRouter.Search>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
    
    
    private func handleTupleToDict(q: String, language: String?=nil, sort: String? = nil, order:String? = nil)->[String: AnyObject]?{
        var query = q
        
        if let language = language{
            query = query + "+language:\(language)"
        }
        var dic = ["q":query]
//        dic.union(["page":"\(page)","per_page":"\(per_page)"])
        if let sort = sort {
            dic = dic.union(["sort":sort])
        }
        
        if let order = order {
            dic = dic.union(["order":order])
        }
        return dic
    }
    
    
}