//
//  UIBezierPath.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


extension UIBezierPath: Renderer {
    func line(to position: CGPoint) {
        addLine(to: position)
    }

    func arc(at center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }

    func setStroke(color: UIColor) {
        color.setStroke()
    }

    func setFill(color: UIColor) {
        color.setFill()
    }
}
