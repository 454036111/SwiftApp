//
//  RepositoryProcess.swift
//  App
//
//  Created by laijihua on 4/1/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation

public extension Process {
    public func repositories(owner: String? = nil, page: String = "1", perPage: String = "100", completion: (response: [Repository]) -> Void){
        
        let router = (owner != nil)
            ? Router.Repository.ReadRepositories(configuration, owner!, page, perPage)
            : Router.Repository.ReadAuthenticatedRepositories(configuration, page, perPage)
        router.provider.request(router).mapArray(Repository.self).subscribeNext { (res) in
            completion(response: res)
        }.addDisposableTo(disposeBag)
    }
    
    public func reponsitory(owner: String, name: String, completion:(response: Repository) -> Void) {
        let router = Router.Repository.ReadRepository(configuration, owner , name)
        router.provider.request(router).mapObject(Repository.self).subscribeNext { (res) in
            completion(response: res)
        }.addDisposableTo(disposeBag)
        
    }
    
    
    
    
    
}