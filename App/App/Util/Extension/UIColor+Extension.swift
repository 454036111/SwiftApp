//
//  UIColor+Extension.swift
//  App
//
//  Created by laijihua on 3/31/16.
//  Copyright © 2016 laijihua. All rights reserved.
//

import UIKit
extension UIColor {
    convenience init?(hexTriplet hex: String) {
        var hexChars = hex.characters
        let red = Int(String(hexChars.prefix(2)), radix: 16)
        hexChars = hexChars.dropFirst(2)
        let green = Int(String(hexChars.prefix(2)), radix: 16)
        hexChars = hexChars.dropFirst(2)
        let blue = Int(String(hexChars), radix: 16)
        if let red = red, green = green, blue = blue {
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
        } else {
            return nil
        }
    }
}
