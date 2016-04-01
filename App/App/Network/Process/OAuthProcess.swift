//
//  OAuthProcess.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import RxSwift

// 这个比较特殊，不放到Process上
public struct OAuthProcess {

    public func authorize(code: String, configtion: OAuthConfiguration, completion: (config: TokenConfiguration?) -> Void) {
        let router = Router.OAuth.AccessToken(configtion, code)
        router.provider.request(router).mapString().subscribeNext { (ret) in
            let accessToken = self.accessTokenFromResponse(ret)
            if let accessToken = accessToken {
                let config = TokenConfiguration(accessToken, url: configtion.apiEndpoint)
                completion(config: config)
            }
        }.addDisposableTo(DisposeBag())
    }
    
    public func accessTokenFromResponse(response: String) -> String? {
        let accessTokenParam = response.componentsSeparatedByString("&").first
        if let accessTokenParam = accessTokenParam {
            return accessTokenParam.componentsSeparatedByString("=").last
        }
        return nil
    }
    
    
    public func handleOpenURL(url: NSURL, configuration:OAuthConfiguration, completion: (config: TokenConfiguration?) -> Void) {
        if let code = url.absoluteString.componentsSeparatedByString("=").last {
            authorize(code , configtion: configuration , completion: { (config) in
                completion(config: config)
            })
        }
    }
}