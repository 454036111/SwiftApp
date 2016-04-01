//
//  NetworkRouter.swift
//  App
//
//  Created by laijihua on 16/2/23.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation
import Moya

typealias HTTPMethod = Moya.Method
typealias HTTPEncoding = Moya.ParameterEncoding
let EmptyString = ""

func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

//var baseURL: NSURL { get }
//var path: String { get }
//var method: Moya.Method { get }
//var parameters: [String: AnyObject]? { get }
//var sampleData: NSData { get }
public protocol RouterProtocol: TargetType  {
    var configuration: Configuration { get }
    var encoding: Moya.ParameterEncoding { get }
    var provider: RxMoyaProvider<Self> { get }
}

//public extension RouterProtocol where Element: TargetType {
//    associatedtype Element
//    var provider: RxMoyaProvider<Self> {
//        return RxMoyaProvider<Element>()
//    }
//    
//}

public extension RouterProtocol {

    var sampleData: NSData {
         return NSData()
    }
}


extension Dictionary{
    public func union(other: Dictionary?) -> Dictionary {
        guard let other = other else{
            return self
        }
        var temp = self
        for (key,value) in other {
            temp.updateValue(value, forKey:key)
        }
        return temp
    }
}




////////////////////////////////////////////////////////





public enum Openness: String {
    case Open = "open"
    case Closed = "closed"
    static func transform(string: String?) -> Openness? {
        if string == "open" {
            return .Open
        } else if string == "closed" {
            return .Closed
        } else {
            return .None
        }
        
    }
}

/**
 *  接口路由类
 */
struct Router {
    static let githubBaseURL = "https://api.github.com"
    static let githubWebURL = "https://github.com"
    
    enum OAuth {
        case Authorize(OAuthConfiguration)
        case AccessToken(OAuthConfiguration, String)
    }

    enum Follow {
        case ReadAuthenticatedFollowers(Configuration)
        case ReadFollowers(String, Configuration)
        case ReadAuthenticatedFollowing(Configuration)
        case ReadFollowing(String, Configuration)
    }
    
    enum Issue {
        case ReadAuthenticatedIssues(Configuration, String, String)
        case ReadIssue(Configuration, String, String, Int)
        case PostIssue(Configuration, String, String, String, String?, String?)
        case PatchIssue(Configuration, String, String, Int, String?, String?, String?, Openness?)
    }
    
    enum PublicKey {
        case PostPublicKey(String, String, Configuration)
    }
    
    enum Repository {
        case ReadRepositories(Configuration, String, String, String)
        case ReadAuthenticatedRepositories(Configuration, String, String)
        case ReadRepository(Configuration, String, String)
    }
    
    enum User {
        case ReadAuthenticatedUser(Configuration)
        case ReadUser(String, Configuration)
    }
    
    enum Stars {
        case ReadAuthenticatedStars(Configuration)
        case ReadStars(String, Configuration)
    }
    
    
    
}




