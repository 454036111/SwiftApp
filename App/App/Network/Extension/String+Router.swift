//
//  String+Router.swift
//  App
//
//  Created by laijihua on 3/30/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import Foundation

public extension String {
//    func stringByAppendingURLPath(path: String) -> String {
//        return path.hasPrefix("/") ? self + path : self + "/" + path
//    }
//    
    func urlEncodedString() -> String? {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        let characterSet = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        characterSet.removeCharactersInString(generalDelimitersToEncode + subDelimitersToEncode)
        return stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
    }
}

