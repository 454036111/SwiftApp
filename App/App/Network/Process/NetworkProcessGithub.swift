//
//  NetworkProcessGithub.swift
//  App
//
//  Created by laijihua on 16/2/23.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation
import RxSwift

extension NetworkProcess {
    // 这里就是对  NetworkRouter.GitHub 进行业务对
    static func userRepositories(name: String, success: ArgoUser? -> (), failure: ErrorHandle? = .None) {
        NetworkRouter.GitHub.Provider
            .request(NetworkRouter.GitHub.UserRepositories("OheroJ"))
            .mapObject(ArgoUser.self)
            .observeOn(MainScheduler.instance)
            .subscribeNext { user in
            success(user)
        }.addDisposableTo(disposeBag)
        
    }
    
}