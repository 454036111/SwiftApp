//
//  Repository.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Repository {
    public let id: Int
    public let owner: User
    public var name: String?
    public var fullName: String?
    public var isPrivate: Bool
    public var repositoryDescription: String?
    public var isFork: Bool?
    public var gitURL: String?
    public var sshURL: String?
    public var cloneURL: String?
    public var htmlURL: String?
    public var size: Int
    public var lastPush: String?
}

extension Repository: Decodable {
    
    public static func create
        (id: Int)
        (owner: User)
        (name: String?)
        (fullName:String?)
        (isPrivate: Bool)
        (respositoryDesc: String?)
        (isFork: Bool?)
        (gitUrl: String?)
        (sshUrl: String?)
        (cloneUrl: String?)
        (htmlUrl: String?)
        (size: Int)
        (lastPush: String?) -> Repository {
        
        return Repository(id: id , owner: owner, name: name , fullName: fullName, isPrivate: isPrivate, repositoryDescription: respositoryDesc, isFork: isFork, gitURL: gitUrl, sshURL: sshUrl, cloneURL: cloneUrl, htmlURL: htmlUrl, size: size , lastPush: lastPush)
        
        
    }
    
    
    public static func decode(json: JSON) -> Decoded<Repository> {
        return Repository.create
            <^> json <| "id"
            <*> json <| "owner"
            <*> json <|? "name"
            <*> json <|? "full_name"
            <*> json <| "private"
            <*> json <|? "description"
            <*> json <|? "fork"
            <*> json <|? "git_url"
            <*> json <|? "ssh_url"
            <*> json <|? "clone_url"
            <*> json <|? "html_url"
            <*> json <| "size"
            <*> json <|? "pushed_at"
    }
    
    
    
    
    
}

