//
//  Constans.swift
//  App
//
//  Created by laijihua on 4/2/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation

struct Constans {
    static let  clientId = "58756da1a326134e7a0c"
    static let  clientSecret = "e18ce57f551d74c05cb77233dd64716e1080f02f"
    static let  authConfig = OAuthConfiguration(token: Constans.clientId, secret: Constans.clientSecret, scopes: ["repo", "read:org"])
    static let authRetUrl = "https://github.com/OHeroJ/SwiftApp"
}


extension Constans {
    
    static var authHtmlUrl: NSURL {
        return Github().authenticate(authConfig)!
    }
    
    
}