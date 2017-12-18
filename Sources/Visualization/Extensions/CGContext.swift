//
//  CGContext.swift
//  Expression
//
//  Created by Michael Pangburn on 12/15/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


// source: https://github.com/objcio/S01E65-playground-quicklook-for-binary-trees/blob/master/Binary%20Tree%20QuickLook.playground/Sources/Helpers.swift
extension CGContext {
    func drawLine(from start: CGPoint, to end: CGPoint, color: UIColor, width: CGFloat) {
        saveGState()
        move(to: start)
        addLine(to: end)
        color.setStroke()
        setLineWidth(width)
        strokePath()
        restoreGState()
    }
}

extension CGContext: Renderer {
    func line(to position: CGPoint) {
        addLine(to: position)
    }

    func arc(at center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        let arc = CGMutablePath()
        arc.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        addPath(arc)
    }

    func setStroke(color: UIColor) {
        setStrokeColor(color.cgColor)
    }

    func setFill(color: UIColor) {
        setFillColor(color.cgColor)
    }

    func stroke() {
        strokePath()
    }

    func fill() {
        fillPath()
    }
}
