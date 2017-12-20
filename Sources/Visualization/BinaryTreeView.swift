//
//  BinaryTreeView.swift
//  Expression
//
//  Created by Michael Pangburn on 12/19/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


public class BinaryTreeNodeView: UIView {

    public var visualAttributes: NodeVisualAttributes? { didSet { setNeedsDisplay() } }

    public var childNodeViews: [BinaryTreeNodeView] = []
    public var childLineViews: [LineView] = []

    public lazy var label: UILabel = {
        let label = UILabel(frame: bounds)
        label.textAlignment = .center
        addSubview(label)
        return label
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func draw(_ rect: CGRect) {
        guard let attributes = visualAttributes else { return }
        label.attributedText = NSAttributedString(string: attributes.text, attributes: attributes.textAttributes)
        backgroundColor = attributes.color
        backgroundColor?.setFill()
        UIGraphicsGetCurrentContext()!.fill(rect)
    }
}

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
        path.line(to: end)
        path.lineWidth = width
        color.setStroke()
        path.stroke()
    }
}

extension PositionedBinaryTree where Tree: EvaluatableExpressionProtocol {
    var left: PositionedBinaryTree<Tree>? {
        return children.first
    }

    var right: PositionedBinaryTree<Tree>? {
        return children.last
    }

    var view: UIView {
        let view = UIView(frame: bounds())
        addNodeViews(to: view)
        return view
    }

    private func addNodeViews(to view: UIView) {
        var nodeQueue = [self]
        var viewQueue = [nodeView]
        while !nodeQueue.isEmpty /*, !viewQueue.isEmpty */ {
            let currentNode = nodeQueue.removeLast()
            let currentNodeView = viewQueue.removeLast()
            if let left = currentNode.left, let right = currentNode.right {
                nodeQueue.insert(contentsOf: [left, right], at: 0)
                let leftNodeView = left.nodeView
                let rightNodeView = right.nodeView
                let childNodeViews = [leftNodeView, rightNodeView]
                currentNodeView.childNodeViews = childNodeViews
                viewQueue.insert(contentsOf: childNodeViews, at: 0)

                let lineSize = CGSize(width: currentNodeView.frame.midX - leftNodeView.frame.midX,
                                      height: leftNodeView.frame.midY - currentNodeView.frame.midY)

                let leftLineOrigin = CGPoint(x: leftNodeView.frame.midX, y: currentNodeView.frame.midY)
                let leftLineView = LineView(frame: CGRect(origin: leftLineOrigin, size: lineSize))
                leftLineView.backgroundColor = .clear
                leftLineView.slantDirection = .right
                leftLineView.color = leftNodeView.visualAttributes!.connectingLineColor
                leftLineView.width = leftNodeView.visualAttributes!.childLineWidth
                currentNodeView.childLineViews.append(leftLineView)
                view.addSubview(leftLineView)

                let rightLineOrigin = CGPoint(x: currentNodeView.frame.midX, y: currentNodeView.frame.midY)
                let rightLineView = LineView(frame: CGRect(origin: rightLineOrigin, size: lineSize))
                rightLineView.backgroundColor = .clear
                rightLineView.slantDirection = .left
                rightLineView.color = rightNodeView.visualAttributes!.connectingLineColor
                rightLineView.width = rightNodeView.visualAttributes!.childLineWidth
                currentNodeView.childLineViews.append(rightLineView)
                view.addSubview(rightLineView)
            }

            view.addSubview(currentNodeView) // needs to happen last so lines go under
        }
    }

    var nodeView: BinaryTreeNodeView {
        guard let attributes = visualAttributes else { return BinaryTreeNodeView(frame: .zero) }
        let cgPtPosition = cgPointPosition
        let visualX = cgPtPosition.x + attributes.size.width / 2 * NodeVisualAttributes.spacingScaleFactor.horizontal
        let visualY = cgPtPosition.y + attributes.size.height / 2 * NodeVisualAttributes.spacingScaleFactor.vertical
        let center = CGPoint(x: visualX, y: visualY)
        let treeNodeView = BinaryTreeNodeView(frame: CGRect(center: center, size: attributes.size))
        treeNodeView.visualAttributes = attributes
        return treeNodeView
    }
}

extension EvaluatableExpressionProtocol {
    public var view: UIView {
        return positioned().view
    }

    public var nodeView: UIView {
        return positioned().nodeView
    }
}
