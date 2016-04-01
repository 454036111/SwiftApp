//
//  Issue.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Issue {
    public var id: Int
    public var url: String?
    public var repositoryURL: String?
    public var labelsURL: String?
    public var commentsURL: String?
    public var eventsURL: String?
    public var htmlURL: String?
    public var number: Int?
    public var state: Openness?
    public var title: String?
    public var body: String?
    public var user: User?
    public var labels: [Label]?
    public var assignee: User?
    public var milestone: Milestone?
    public var locked: Bool?
    public var comments: Int?
    public var closedAt: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var closedBy: User?
}

extension Issue: Decodable {
    
    static func create
        (_ id: Int)
        (_ url: String?)
        (_ repositoryURL: String?)
        (_ labelsURL: String?)
        (_ commentsURL: String?)
        (_ eventsURL: String?)
        (_ htmlURL: String?)
        (_ number: Int?)
        (_ state: String?)
        (_ title: String?)
        (_ body: String?)
        (_ locked: Bool?)
        (_ comments: Int?)
        (_ closedAt: String?)
        (_ createdAt: String?)
        (_ updatedAt: String?)
        (_ user: User?)
        (_ labels: [Label]?)
        (_ assignee: User?)
        (_ milestone: Milestone?)
        (_ closedBy: User?) -> Issue {
            
        let stat = Openness.transform(state)
        return Issue(id: id , url: url , repositoryURL: repositoryURL, labelsURL: labelsURL, commentsURL: commentsURL, eventsURL: eventsURL, htmlURL: htmlURL, number: number, state: stat, title: title, body: body, user: user, labels: labels, assignee: assignee, milestone: milestone, locked: locked, comments: comments, closedAt: closedAt, createdAt: createdAt, updatedAt: updatedAt, closedBy: closedBy)
    }
    
    
    
    
    public static func decode(json: JSON) -> Decoded<Issue> {

        let tmp = Issue.create
            <^> json <| "id"
            <*> json <|? "url"
            <*> json <|? "repository_url"
            <*> json <|? "labels_url"
            <*> json <|? "comments_url"
            <*> json <|? "events_url"
            <*> json <|? "html_url"
            <*> json <|? "number"
            <*> json <|? "state"
            <*> json <|? "title"
            <*> json <|? "body"
            <*> json <|? "locked"
            <*> json <|? "comments"
        
        let ret = tmp
            <*> json <|? "closed_at"
            <*> json <|? "created_at"
            <*> json <|? "updated_at"
            <*> json <|? "user"
            <*> json <||? "labels"
            <*> json <|? "assignee"
            <*> json <|? "milestone"
            <*> json <|? "close_by"
        
        return  ret
        
    }
    
    
    
    
    
}





