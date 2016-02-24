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
    static func userRepositories(name: String, success: [ArgoUser]? -> (), failure: ErrorHandle? = .None) {
        NetworkRouter.GitHub.Provider
            .request(NetworkRouter.GitHub.UserRepositories(name))
            .mapArray(ArgoUser.self)
//            .observeOn(MainScheduler.instance) // 这不需要
            .subscribeNext { users in
                print("是不是在主线程：\(NSThread.currentThread().isMainThread)")
                success(users)
        }.addDisposableTo(disposeBag)
    }
}