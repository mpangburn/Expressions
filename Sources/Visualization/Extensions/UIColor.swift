//
//  UIColor.swift
//  Expression
//
//  Created by Michael Pangburn on 12/15/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


extension UIColor {

    static let flatBlue = UIColor(hexString: "#44BBFF")
    static let flatRed = UIColor(hexString: "#FC575E")
    static let flatGreen = UIColor(hexString: "#66CC99")

    // source: http://iosapptemplates.com/blog/swift-programming/convert-hex-colors-to-uicolor-swift-4
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
