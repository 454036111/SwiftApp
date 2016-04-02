//
//  OAuthProcess.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import RxSwift

public extension Process {
    public func authenticate(config: OAuthConfiguration) -> NSURL? {
        let router = Router.OAuth.Authorize(config)
        let url =  [router.baseURL.URLByAppendingPathComponent(router.path).absoluteString, urlQuery(router.parameters)].joinWithSeparator("?")
        return NSURL(string: url)
    }
    
    public func urlQuery(parameters: [String: AnyObject]?) -> String {
        guard let parameters = parameters else { return EmptyString}
        var components: [(String, String)] = []
        for key in parameters.keys.sort(<) {
            if let value = parameters[key] {
                if value is String {
                    let encodedValue = (value as! String).urlEncodedString()
                    components.append(key, encodedValue!)
                }
            }
        }
        return components.map{"\($0)=\($1)"}.joinWithSeparator("&")
    }
    
    
    
    public  func authorize(code: String, configtion: OAuthConfiguration, completion: (config: TokenConfiguration?) -> Void) {
        let router = Router.OAuth.AccessToken(configtion, code)
        
        router.provider.request(router).subscribeNext { (res) in
            print("😊😊😊😊😊😊accessToken:\(res)")
        }.addDisposableTo(disposeBag)
//        router.provider.request(router).mapString().subscribeNext { (ret) in
//            let accessToken = self.accessTokenFromResponse(ret)
//            if let accessToken = accessToken {
//                let config = TokenConfiguration(token: accessToken, url: configtion.apiEndpoint)
//                completion(config: config)
//            }
//        
//        }.addDisposableTo(disposeBag)
    }
    
    public  func accessTokenFromResponse(response: String) -> String? {
        let accessTokenParam = response.componentsSeparatedByString("&").first
        if let accessTokenParam = accessTokenParam {
            return accessTokenParam.componentsSeparatedByString("=").last
        }
        return nil
    }
    
    
    public  func handleOpenURL(url: NSURL, configuration:OAuthConfiguration, completion: (config: TokenConfiguration?) -> Void) {
        if let code = url.absoluteString.componentsSeparatedByString("=").last {
            // 获取到code， 请求获取accesstoken
            authorize(code , configtion: configuration , completion: { (config) in
                completion(config: config)
            })
        }
    }
}