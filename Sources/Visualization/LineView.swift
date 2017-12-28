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
    public enum Direction {
        case vertical
        case horizontal
        case slantedLeft
        case slantedRight
    }

    public var direction: Direction = .slantedLeft { didSet { setNeedsDisplay() } }
    public var color: UIColor = .black { didSet { setNeedsDisplay() } }
    public var width: CGFloat = 1 { didSet { setNeedsDisplay() } }

    override public func draw(_ bounds: CGRect) {
        let path = UIBezierPath()
        let (start, end) = lineEndPoints(from: direction)
        path.move(to: start)
        path.addLine(to: end)
        path.lineWidth = width
        color.setStroke()
        path.stroke()
    }

    private func lineEndPoints(from direction: Direction) -> (start: CGPoint, end: CGPoint) {
        let start: CGPoint
        let end: CGPoint
        switch direction {
        case .vertical:
            start = CGPoint(x: bounds.midX, y: bounds.maxY)
            end = CGPoint(x: bounds.midX, y: bounds.minY)
        case .horizontal:
            start = CGPoint(x: bounds.minX, y: bounds.midY)
            end = CGPoint(x: bounds.maxX, y: bounds.midY)
        case .slantedLeft:
            start = CGPoint(x: bounds.minX, y: bounds.minY)
            end = CGPoint(x: bounds.maxX, y: bounds.maxY)
        case .slantedRight:
            start = CGPoint(x: bounds.minX, y: bounds.maxY)
            end = CGPoint(x: bounds.maxX, y: bounds.minY)
        }
        return (start, end)
    }
}
