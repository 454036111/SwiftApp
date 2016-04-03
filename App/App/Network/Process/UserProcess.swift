//
//  UserProcess.swift
//  App
//
//  Created by laijihua on 4/1/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Moya
import RxSwift


private var userProvider = RxMoyaProvider<Router.User>()

public extension Process {
    public func user(name: String, completion: (response: User) -> Void) {
        let router = Router.User.ReadUser(name , configuration)
        
        userProvider = router.provider
//        userProvider.request(router) {res in
//            print(res)
//        }
        userProvider.request(router).mapObject(User.self).subscribe(onNext: { (user) in
            print(user )
            }, onError: { (err) in
                print(err)
            }, onCompleted: { 
                
            }) { 
                
        }.addDisposableTo(disposeBag)
        
//        userProvider.request(router).mapObject(User.self).subscribeNext { (res) in
//            completion(response: res)
//        }.addDisposableTo(disposeBag)
    }
    
    public func me(completion: (response: User) -> Void) {
        let router = Router.User.ReadAuthenticatedUser(configuration)
        userProvider = router.provider
        userProvider.request(router).mapObject(User.self).subscribeNext { (res) in
            completion(response: res)
        }.addDisposableTo(disposeBag)
    }
    
    
}
