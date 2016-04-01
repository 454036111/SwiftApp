//
//  Label.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import UIKit
import Argo
import Curry
public struct Label {
    let url: String
    let name: String
    let color: String 
}

extension Label: Decodable {
    public static func decode(json: JSON) -> Decoded<Label> {
        return curry(Label.init)
            <^> json <| "url"
            <*> json <| "name"
            <*> json <| "color"
    }
    
    
    
}

