//
//  FollowProcess.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation


public extension Process {
    public func myFollower(completion: (response: [User]) -> Void ) {
        let router = Router.Follow.ReadAuthenticatedFollowers(configuration)
        router.provider.request(router).mapArray(User.self).subscribeNext { (users) in
            completion(response: users)
        }.addDisposableTo(disposeBag)
    }
    
    public func followers(name: String, completion: (response: [User]) -> Void) {
        let router = Router.Follow.ReadFollowers(name , configuration)
        router.provider.request(router).mapArray(User.self).subscribeNext { (users) in
            completion(response: users)
        }.addDisposableTo(disposeBag)
    }
    
    
    public func myFollowing(completion: (response: [User]) -> Void) {
        let router = Router.Follow.ReadAuthenticatedFollowing(configuration)
        router.provider.request(router).mapArray(User.self).subscribeNext { (users) in
            completion(response: users)
            }.addDisposableTo(disposeBag)
    }
    
    
    public func following(name: String, completion: (response: [User]) -> Void ) {
        let router = Router.Follow.ReadFollowing(name , configuration)
        router.provider.request(router).mapArray(User.self).subscribeNext { (users) in
            completion(response: users)
            }.addDisposableTo(disposeBag)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
