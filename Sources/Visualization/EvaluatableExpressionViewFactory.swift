//
//  EvaluatableExpressionViewFactory.swift
//  Expression
//
//  Created by Michael Pangburn on 12/22/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


public struct EvaluatableExpressionViewFactory {

    private init() {}

    /// Returns a tuple of 1) a UIView containing properly positioned node views making up the tree,
    /// and 2) the root node view for use in accessing the structure of these subviews.
    public static func makeView<T>(of expression: T) -> (superview: UIView, rootNodeView: BinaryTreeNodeView) where T: EvaluatableExpressionProtocol {
        let positionedTree = expression.positioned()
        let superview = UIView(frame: positionedTree.bounds())
        superview.backgroundColor = .white
        let rootNodeView = addNodeViews(of: positionedTree, to: superview)
        return (superview, rootNodeView)
    }

    private static func addNodeViews<T>(of positionedTree: PositionedBinaryTree<T>, to view: UIView) -> BinaryTreeNodeView where T: EvaluatableExpressionProtocol {
        let rootNodeView = nodeView(of: positionedTree)
        var nodeQueue = [positionedTree]
        var viewQueue = [rootNodeView]
        while !nodeQueue.isEmpty /*, !viewQueue.isEmpty */ {
            let currentNode = nodeQueue.removeLast()
            let currentNodeView = viewQueue.removeLast()
            if let left = currentNode.children.first, let right = currentNode.children.last {
                nodeQueue.insert(contentsOf: [left, right], at: 0)
                let leftNodeView = nodeView(of: left)
                let rightNodeView = nodeView(of: right)
                let childNodeViews = [leftNodeView, rightNodeView]
                currentNodeView.childNodeViews = childNodeViews
                viewQueue.insert(contentsOf: childNodeViews, at: 0)

                let leftLineSize = CGSize(width: currentNodeView.frame.midX - leftNodeView.frame.midX,
                                          height: leftNodeView.frame.midY - currentNodeView.frame.midY)
                let leftLineOrigin = CGPoint(x: leftNodeView.frame.midX, y: currentNodeView.frame.midY)
                let leftLineView = LineView(frame: CGRect(origin: leftLineOrigin, size: leftLineSize))
                leftLineView.slantDirection = .right

                let rightLineSize = CGSize(width: rightNodeView.frame.midX - currentNodeView.frame.midX,
                                           height: rightNodeView.frame.midY - currentNodeView.frame.midY)
                let rightLineOrigin = CGPoint(x: currentNodeView.frame.midX, y: currentNodeView.frame.midY)
                let rightLineView = LineView(frame: CGRect(origin: rightLineOrigin, size: rightLineSize))
                rightLineView.slantDirection = .left

                for (lineView, nodeView) in zip([leftLineView, rightLineView], [leftNodeView, rightNodeView]) {
                    lineView.backgroundColor = .clear
                    guard let attributes = nodeView.visualAttributes else { fatalError("Child node view improperly configured") }
                    lineView.color = attributes.connectingLineColor
                    lineView.width = attributes.childLineWidth
                    currentNodeView.childLineViews.append(lineView)
                    view.addSubview(lineView)
                }
            }

            view.addSubview(currentNodeView) // add node view last to go on top of line views
        }

        return rootNodeView
    }

    private static func nodeView<T>(of positionedTree: PositionedBinaryTree<T>) -> BinaryTreeNodeView where T: EvaluatableExpressionProtocol {
        guard let attributes = positionedTree.visualAttributes else { return BinaryTreeNodeView(frame: .zero) }
        let cgPointPosition = positionedTree.cgPointPosition
        let visualX = cgPointPosition.x + attributes.size.width / 2 * NodeVisualAttributes.spacingScaleFactor.horizontal
        let visualY = cgPointPosition.y + attributes.size.height / 2 * NodeVisualAttributes.spacingScaleFactor.vertical
        let center = CGPoint(x: visualX, y: visualY)
        let treeNodeView = BinaryTreeNodeView(frame: CGRect(center: center, size: attributes.size))
        treeNodeView.visualAttributes = attributes
        let (evaluatedText, evaluatedColor) = positionedTree.tree.evaluatedNodeAttributes
        treeNodeView.nextLabelText = evaluatedText
        treeNodeView.nextColor = evaluatedColor
        treeNodeView.label.attributedText = NSAttributedString(string: attributes.text, attributes: attributes.textAttributes)
        treeNodeView.backgroundColor = attributes.color
        return treeNodeView
    }
}
