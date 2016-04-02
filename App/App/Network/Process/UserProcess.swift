//
//  UserProcess.swift
//  App
//
//  Created by laijihua on 4/1/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation

public extension Process {
    public func user(name: String, completion: (response: User) -> Void) {
        let router = Router.User.ReadUser(name , configuration)
        
        router.provider.request(router) {res in
            print(res)
        }
//        
//        router.provider.request(router).mapObject(User.self).subscribeNext { (res) in
//            completion(response: res)
//        }.addDisposableTo(disposeBag)
    }
    
    public func me(completion: (response: User) -> Void) {
        let router = Router.User.ReadAuthenticatedUser(configuration)
        router.provider.request(router).mapObject(User.self).subscribeNext { (res) in
            completion(response: res)
        }.addDisposableTo(disposeBag)
    }
    
    
}
