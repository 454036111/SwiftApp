//
//  StartsProcess.swift
//  App
//
//  Created by laijihua on 4/1/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Moya

private var starProvider = RxMoyaProvider<Router.Stars>()
public extension Process {
    
    public func stars(name:String, completion:(reponse: [Repository]) -> Void) {
        let router = Router.Stars.ReadStars(name, configuration)
        starProvider = router.provider
        starProvider.request(router).mapArray(Repository.self).subscribeNext { (res) in
            completion(reponse: res)
        }.addDisposableTo(disposeBag)
    }
    
    public func myStars(completion: (response: [Repository]) -> Void) {
        let router = Router.Stars.ReadAuthenticatedStars(configuration)
        router.provider.request(router).mapArray(Repository.self).subscribeNext { (res) in
            completion(response: res)
        }.addDisposableTo(disposeBag)
    }
}


