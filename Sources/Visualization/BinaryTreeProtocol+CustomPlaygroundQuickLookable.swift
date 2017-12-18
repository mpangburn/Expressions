//
//  BinaryTreeProtocol+CustomPlaygroundQuickLookable.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


extension CustomPlaygroundQuickLookableBinaryTreeProtocol {

    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return .image(render())
    }

    /// Renders an image of the tree with minimized width.
    public func render() -> UIImage {
        let positionedTree = positioned()
        let imageBounds = positionedTree.bounds()
        return UIGraphicsImageRenderer(bounds: imageBounds).image() { context in
            render(positionedTree: positionedTree, into: context.cgContext)
        }
    }

    /// Returns the tree with positions applied to each of its nodes.
    func positioned() -> PositionedBinaryTree<Self> {
        return PositionedBinaryTree.reingoldTilford(tree: self)
    }

    /// Recursively renders the tree into the context.
    private func render(positionedTree: PositionedBinaryTree<Self>, into context: CGContext, connectingTo parentPosition: CGPoint? = nil) {
        let attributes = positionedTree.visualAttributes
        let nodePosition = positionedTree.cgPointPosition

        positionedTree.children.forEach { child in
            render(positionedTree: child, into: context, connectingTo: nodePosition)
        }

        if let parentPosition = parentPosition {
            context.drawLine(from: nodePosition, to: parentPosition, color: attributes.connectingLineColor, width: NodeVisualAttributes.childLineWidth)
        }

        attributes.color.setFill()
        context.fillEllipse(in: CGRect(center: nodePosition, size: NodeVisualAttributes.nodeSize))
        attributes.text.draw(centeredAt: nodePosition, attributes: attributes.textAttributes)
    }
}
