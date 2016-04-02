//
//  PublicKeyProcess.swift
//  App
//
//  Created by laijihua on 4/1/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation

public extension Process {
    public func postPublicKey(publicKey: String ,title: String,completion: (ret: String) -> Void ) {
        let router = Router.PublicKey.PostPublicKey(publicKey, title , configuration)
        router.provider.request(router).mapString().subscribeNext { (ret) in
            completion(ret: ret)
        }.addDisposableTo(disposeBag)
    }
}
