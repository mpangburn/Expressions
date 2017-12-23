//
//  LineView.swift
//  Expression
//
//  Created by Michael Pangburn on 12/21/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


/// A view containing a line drawn diagonally across its bounds.
public class LineView: UIView {
    enum SlantDirection { case left, right }

    var slantDirection: SlantDirection = .left

    var color: UIColor = .black

    var width: CGFloat = 1

    override public func draw(_ bounds: CGRect) {
        let start: CGPoint
        let end: CGPoint
        switch slantDirection {
        case .left:
            start = CGPoint(x: bounds.minX, y: bounds.minY)
            end = CGPoint(x: bounds.maxX, y: bounds.maxY)
        case .right:
            start = CGPoint(x: bounds.minX, y: bounds.maxY)
            end = CGPoint(x: bounds.maxX, y: bounds.minY)
        }

        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.lineWidth = width
        color.setStroke()
        path.stroke()
    }
}
