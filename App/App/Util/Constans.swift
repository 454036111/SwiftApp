//
//  Constans.swift
//  App
//
//  Created by laijihua on 4/2/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation

protocol StoryProtocol {
    static func save(value: AnyObject?, key: Constans.StoryKey) -> Void
    static func getValue(key:Constans.StoryKey) -> AnyObject?
}

struct Constans {
    static let  clientId = "58756da1a326134e7a0c"
    static let  clientSecret = "e18ce57f551d74c05cb77233dd64716e1080f02f"
    static let  authConfig = OAuthConfiguration(token: Constans.clientId, secret: Constans.clientSecret, scopes: ["repo", "read:org"])
    static let authRetUrl = "https://github.com/OHeroJ/SwiftApp"
    
    
    enum StoryKey:String {
        case AccessToken = "StoryKey_AccessToken"
    }
}

extension Constans {
    static var authHtmlUrl: NSURL {
        return Github().authenticate(authConfig)!
    }
}


extension Constans: StoryProtocol {
    static func save(value: AnyObject?, key: Constans.StoryKey) {
        let handler = NSUserDefaults.standardUserDefaults()
        handler.setValue(value , forKey: key.rawValue)
        handler.synchronize()
    }
    
    static func getValue(key: Constans.StoryKey) -> AnyObject? {
        let handler = NSUserDefaults.standardUserDefaults()
        return handler.valueForKey(key.rawValue)
    }
}

