//
//  CGContext.swift
//  Expression
//
//  Created by Michael Pangburn on 12/15/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


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
