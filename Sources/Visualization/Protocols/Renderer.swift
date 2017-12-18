//
//  Renderer.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import CoreGraphics


// c.f. https://developer.apple.com/videos/play/wwdc2015/408/
protocol Renderer {
    /// Moves the pen to `position` without drawing anything.
    func move(to position: CGPoint)

    /// Draws a line from the pen's current position to `position`, updating
    /// the pen position.
    func line(to position: CGPoint)

    /// Draws the fragment of the circle centered at `c` having the given
    /// `radius`, that lies between `startAngle` and `endAngle`, measured in
    /// radians.
    func arc(at center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat)

    func setStroke(color: UIColor)
    func setFill(color: UIColor)

    func stroke()
    func fill()
}

extension Renderer {
    func circle(at center: CGPoint, radius: CGFloat) {
        arc(at: center, radius: radius, startAngle: 0, endAngle: 2 * .pi)
    }

    func text(_ text: String, atCenter center: CGPoint, attributes: [NSAttributedStringKey: Any]) {
        text.draw(centeredAt: center, attributes: attributes)
    }
}
