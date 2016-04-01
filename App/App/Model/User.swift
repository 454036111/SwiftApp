//
//  User.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct User {
    public let id: Int
    public var login: String
    public var avatarURL: String
    public var gravatarID: String
    public var type: String
    public var name: String
    public var company: String
    public var blog: String
    public var location: String
    public var email: String
    public var numberOfPublicRepos: Int
    public var numberOfPublicGists: Int
    public var numberOfPrivateRepos: Int
}

extension User: Decodable {
    
    public static func create
        (id: Int)
        (login: String)
        (avatarURL: String)
        (gravatarID: String)
        (type: String)
        (name: String)
        (company: String)
        (blog: String)
        (location: String)
        (email: String)
        (numberOfPublicRepos: Int )
        (numberOfPublicGists: Int )
        (numberOfPrivateRepos: Int ) -> User {
            return User(id: id, login: login, avatarURL: avatarURL, gravatarID: gravatarID, type: type, name: name , company: company , blog: blog , location: location , email: email , numberOfPublicRepos: numberOfPublicRepos, numberOfPublicGists: numberOfPublicGists, numberOfPrivateRepos: numberOfPrivateRepos)
    }
    
    public static func decode(json: JSON) -> Decoded<User> {

        let tmp = User.create
            <^> json <| "id"
            <*> json <| "login"
            <*> json <| "avatar_url"
            <*> json <| "gravatar_id"
            <*> json <| "type"
            <*> json <| "name"
            <*> json <| "company"
            <*> json <| "blog"
            <*> json <| "location"
            <*> json <| "email"
            <*> json <| "public_repos"
            <*> json <| "public_gists"
            <*> json <| "total_private_repos"
        return tmp
    }
    
    
    
}






