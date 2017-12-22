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
    public var nextLabelText = ""
    public var nextColor: UIColor = .clear

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

    public func updateText() {
        guard let attributes = self.visualAttributes else { return }
        label.attributedText = NSAttributedString(string: self.nextLabelText, attributes: attributes.textAttributes)

        UIView.animate(withDuration: 0.3, animations: {
            if let left = self.childNodeViews.first, let right = self.childNodeViews.last {
                left.alpha = 0
                right.alpha = 0
            }
            UIView.animate(withDuration: 2.0, animations: {
                self.label.alpha = 1
                self.backgroundColor = self.nextColor
            })
        })
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

    func makeView() -> (superview: UIView, rootNodeView: BinaryTreeNodeView) {
        let superview = UIView(frame: bounds())
        superview.backgroundColor = .white // Playground live view doesn't support transparency?
        let rootNodeView = addNodeViews(to: superview)
        return (superview, rootNodeView)
    }

    private func addNodeViews(to view: UIView) -> BinaryTreeNodeView {
        let rootNodeView = nodeView
        var nodeQueue = [self]
        var viewQueue = [rootNodeView]
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

        return rootNodeView
    }

    var nodeView: BinaryTreeNodeView {
        guard let attributes = visualAttributes else { return BinaryTreeNodeView(frame: .zero) }
        let cgPtPosition = cgPointPosition
        let visualX = cgPtPosition.x + attributes.size.width / 2 * NodeVisualAttributes.spacingScaleFactor.horizontal
        let visualY = cgPtPosition.y + attributes.size.height / 2 * NodeVisualAttributes.spacingScaleFactor.vertical
        let center = CGPoint(x: visualX, y: visualY)
        let treeNodeView = BinaryTreeNodeView(frame: CGRect(center: center, size: attributes.size))
        treeNodeView.visualAttributes = attributes
        let (evaluatedText, evaluatedColor) = tree.evaluatedNodeAttributes
        treeNodeView.nextLabelText = evaluatedText
        treeNodeView.nextColor = evaluatedColor
        treeNodeView.label.attributedText = NSAttributedString(string: attributes.text, attributes: attributes.textAttributes)
        treeNodeView.backgroundColor = attributes.color
        return treeNodeView
    }
}

extension EvaluatableExpressionProtocol {
    public func makeView() -> (superview: UIView, rootNodeView: BinaryTreeNodeView) {
        return positioned().makeView()
    }

    public var nodeView: UIView {
        return positioned().nodeView
    }
}
