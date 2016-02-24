//
//  ArgoUser.swift
//  App
//
//  Created by laijihua on 16/2/23.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import Foundation
import Argo
import Curry


/**
 *  Test Model
 */

struct ArgoOwner {
    let id: Int
    let gravatar_id: String
    let site_admin: Bool
    let login: String
    let avatar_url: String
    let type: String
    
    
}

extension ArgoOwner: Decodable {
    static func decode(json: JSON) -> Decoded<ArgoOwner> {
        return curry(ArgoOwner.init)
            <^> json <| "id"
            <*> json <| "gravatar_id"
            <*> json <| "site_admin"
            <*> json <| "login"
            <*> json <| "avatar_url"
            <*> json <| "type"
    }
}

struct ArgoUser {
    let default_branch: String
    let id: Int
    let owner: ArgoOwner
    let watchers: Int
    let clone_url: String
    let has_wiki: Bool
    let url: String
    let fork: Bool
    let description: String?
    let has_issues: Bool
    let privat: Bool
    let size: Int
    let updated_at: String
    let name: String
    let open_issues_count: Int
    let forks_count: Int
    let svn_url: String
    let created_at: String
    let forks_url: String
    let has_downloads: Bool
    let git_url: String
    let forks: Int
    let open_issues: Int
    let full_name: String
    let downloads_url: String
    let stargazers_count: Int
    let watchers_count: Int
    let language: String
    let has_pages: Bool
}


//extension ArgoUser: UserType {} // 给 view提供数据

extension ArgoUser: Decodable {
    static func decode(json: JSON) -> Decoded<ArgoUser> {
        let tmp = ArgoUser.create
            <^> json <| "default_branch"
            <*> json <| "id"
            <*> json <| "owner"
            <*> json <| "watchers"
            <*> json <| "clone_url"
            <*> json <| "has_wiki"
            <*> json <| "url"
            <*> json <| "fork"
            <*> json <|? "description"
            <*> json <| "has_issues"
            <*> json <| "private"
            <*> json <| "size"
            <*> json <| "updated_at"
        
        let ret = tmp
            <*> json <| "name"
            <*> json <| "open_issues_count"
            <*> json <| "forks_count"
            <*> json <| "svn_url"
            <*> json <| "created_at"
            <*> json <| "forks_url"
            <*> json <| "has_downloads"
            <*> json <| "git_url"
            <*> json <| "forks"
            <*> json <| "open_issues"
            <*> json <| "full_name"
            <*> json <| "downloads_url"
            <*> json <| "stargazers_count"
            <*> json <| "watchers_count"
            <*> json <| "language"
            <*> json <| "has_pages"
        
        return ret
   
// Expression was too complex to be solved in reasonable
//        return curry(ArgoUser.create)
//            <^> json <| "default_branch"
//            <*> json <| "id"
//            <*> json <| "owner"
//            <*> json <| "watchers"
//            <*> json <| "clone_url"
//            <*> json <| "has_wiki"
//            <*> json <| "url"
//            <*> json <| "fork"
//            <*> json <| "description"
//            <*> json <| "has_issues"
//            <*> json <| "private"
//            <*> json <| "size"
//            <*> json <| "updated_at"
//            <*> json <| "name"
//            <*> json <| "open_issues_count" //
//            <*> json <| "forks_count"
//            <*> json <| "svn_url"
//            <*> json <| "created_at"
//            <*> json <| "forks_url"
//            <*> json <| "has_downloads"
//            <*> json <| "git_url"
//            <*> json <| "forks"
//            <*> json <| "open_issues"
//            <*> json <| "full_name"
//            <*> json <| "downloads_url"
//            <*> json <| "stargazers_count"
//            <*> json <| "watchers_count"
//            <*> json <| "language"
//            <*> json <| "has_pages"
    
    }
    
    
    static func create
        (default_branch: String)
        (_ id: Int)
        (_ owner: ArgoOwner)
        (_ watchers: Int)
        (_ clone_url: String)
        (_ has_wiki: Bool)
        (_ url: String)
        (_ fork: Bool)
        (_ description: String?)
        (_ has_issues: Bool)
        (_ privat: Bool)
        (_ size: Int)
        (_ updated_at: String)
        (_ name: String)
        (_ open_issues_count: Int)
        (_ forks_count: Int)
        (_ svn_url: String)
        (_ created_at: String)
        (_ forks_url: String)
        (_ has_downloads: Bool)
        (_ git_url: String)
        (_ forks: Int)
        (_ open_issues: Int)
        (_ full_name: String)
        (_ downloads_url: String)
        (_ stargazers_count: Int)
        (_ watchers_count: Int)
        (_ language: String)
        (_ has_pages: Bool)-> ArgoUser{
            return ArgoUser(default_branch: default_branch, id: id, owner: owner, watchers: watchers, clone_url: clone_url, has_wiki: has_wiki, url: url, fork: fork, description: description, has_issues: has_issues, privat: privat, size: size, updated_at: updated_at, name: name, open_issues_count: open_issues_count, forks_count: forks_count, svn_url: svn_url, created_at: created_at, forks_url: forks_url, has_downloads: has_downloads, git_url: git_url, forks: forks, open_issues: open_issues, full_name: full_name, downloads_url: downloads_url, stargazers_count: stargazers_count, watchers_count: watchers_count, language: language, has_pages: has_pages)
            
    }
}
