//
//  Milestone.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Milestone {
    public var htmlURL: String?
    public var labelsURL: String?
    public var id: Int
    public var number: Int?
    public var state: Openness?
    public var title: String?
    public var milestoneDescription: String?
    public var creator: User?
    public var openIssues: Int?
    public var closedIssues: Int?
    public var createdAt: String?
    public var updatedAt: String?
    public var closedAt: String?
    public var dueOn: String?
}

extension Milestone: Decodable {
    
    public static func create
        (htmlURL: String?)
        (labelsURL: String?)
        (id: Int)
        (number: Int?)
        (state: String?)
        (title: String?)
        (milestoneDescription: String?)
        (creator: User?)
        (openIssues: Int?)
        (closedIssues: Int?)
        (createdAt: String?)
        (updatedAt: String?)
        (closedAt: String?)
        (dueOn: String?) -> Milestone {
        let sta = Openness.transform(state)
        
        return Milestone( htmlURL: htmlURL, labelsURL: labelsURL, id: id , number: number, state: sta, title: title, milestoneDescription: milestoneDescription, creator: creator, openIssues: openIssues, closedIssues: closedIssues, createdAt: createdAt, updatedAt: updatedAt, closedAt: closedAt, dueOn: dueOn)
        
    }
    
    public static func decode(json: JSON) -> Decoded<Milestone> {
        let tmp = Milestone.create
            <^> json <|? "html_url"
            <*> json <|? "labels_url"
            <*> json <| "id"
            <*> json <|? "number"
            <*> json <|? "state"
            <*> json <|? "title"
            <*> json <|? "description"
            <*> json <|? "creator"
            <*> json <|? "open_issues"
            <*> json <|? "closed_issues"
            <*> json <|? "created_at"
            <*> json <|? "updated_at"
            <*> json <|? "closed_at"
            <*> json <|? "due_on"
        
        return tmp
    }
    
}












