//
//  String.swift
//  Expression
//
//  Created by Michael Pangburn on 12/15/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import CoreGraphics


extension String {
    func draw(centeredAt center: CGPoint, attributes: [NSAttributedStringKey: Any]) {
        let size = (self as NSString).size(withAttributes: attributes)
        let bounds = CGRect(center: center, size: size)
        (self as NSString).draw(in: bounds, withAttributes: attributes)
    }
}
