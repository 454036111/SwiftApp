//
//  Configuration.swift
//  App
//
//  Created by laijihua on 3/30/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation

public protocol Configuration {
    var apiEndpoint: String { get }
    var accessToken: String? { get }
    var accessTokenFieldName: String { get }
}

public extension Configuration {
    var accessTokenFieldName: String {
        return "access_token"
    }
}

public struct TokenConfiguration: Configuration {
    public var apiEndpoint: String
    public var accessToken: String?
    
    public init(_ token: String? = nil, url: String = Router.githubWebURL){
        apiEndpoint = url
        accessToken = token
    }
}

public struct OAuthConfiguration: Configuration {
    public var apiEndpoint: String
    public var accessToken: String?
    public let token: String
    public let secret: String
    public let scopes: [String]
    public let webEndpoint: String
    
    public init(_ url: String = Router.githubBaseURL, webURL: String = Router.githubWebURL,
                  token: String, secret: String, scopes: [String]) {
        apiEndpoint = url
        webEndpoint = webURL
        self.token = token
        self.secret = secret
        self.scopes = scopes
    }
    

}






