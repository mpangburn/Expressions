//
//  CustomPlaygroundQuickLookableBinaryTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


public protocol CustomPlaygroundQuickLookableBinaryTreeProtocol: BinaryTreeProtocol, CustomPlaygroundQuickLookable {
    var visualAttributes: NodeVisualAttributes? { get }
}

// MARK: - Default implementations

extension CustomPlaygroundQuickLookableBinaryTreeProtocol {
    public var visualAttributes: NodeVisualAttributes? {
        guard let kind = kind else { return nil }

        let size = NodeVisualAttributes.Default.size
        let color: UIColor
        let text: String
        let textAttributes = NodeVisualAttributes.Default.textAttributes

        switch kind {
        case let .leaf(value):
            color = .flatBlue
            text = String(describing: value)
        case let .node(value):
            color = .flatRed
            text = String(describing: value)
        }

        let connectingLineColor = color

        return NodeVisualAttributes(size: size, color: color, text: text, textAttributes: textAttributes, connectingLineColor: connectingLineColor)
    }
}

extension CustomPlaygroundQuickLookableBinaryTreeProtocol {

    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return .image(render())
    }

    /// Renders an image of the tree with minimized width.
    public func render() -> UIImage {
        guard !isEmpty else { return UIImage() }
        let positionedTree = positioned()
        let imageBounds = positionedTree.bounds()
        return UIGraphicsImageRenderer(bounds: imageBounds).image() { context in
            render(positionedTree, into: context.cgContext)
        }
    }

    /// Returns the tree with positions applied to each of its nodes.
    func positioned() -> PositionedBinaryTree<Self> {
        return PositionedBinaryTree.reingoldTilford(tree: self)
    }

    /// Recursively renders the tree into the context.
    private func render(_ positionedTree: PositionedBinaryTree<Self>, into context: CGContext, connectingTo parentPosition: CGPoint? = nil) {
        guard let attributes = positionedTree.visualAttributes else { return }
        let nodePosition = positionedTree.cgPointPosition

        positionedTree.children.forEach { child in
            render(child, into: context, connectingTo: nodePosition)
        }

        if let parentPosition = parentPosition {
            context.drawLine(from: nodePosition, to: parentPosition, color: attributes.connectingLineColor, width: NodeVisualAttributes.Default.childLineWidth)
        }

        attributes.color.setFill()
        context.fillEllipse(in: CGRect(center: nodePosition, size: attributes.size))
        attributes.text.draw(centeredAt: nodePosition, attributes: attributes.textAttributes)
    }
}

// MARK: - Wide render
// c.f. https://talk.objc.io/episodes/S01E65-playground-quicklook-for-binary-trees
extension CustomPlaygroundQuickLookableBinaryTreeProtocol {

    /// Renders the image whose width is computed as a function of the tree's height.
    /// This can easily result in trees that appear to be stretched wide,
    /// but has the advantage of being able to distinguish between a left and a right child
    /// in cases where a node has only a single child.
    public func renderWide() -> UIImage {
        guard let attributes = visualAttributes else { return UIImage() }
        let treeHeight = height
        let bounds = wideBounds(forHeight: treeHeight)
        let center = CGPoint(x: bounds.midX, y: attributes.size.height / 2 * NodeVisualAttributes.spacingScaleFactor.vertical)
        return UIGraphicsImageRenderer(bounds: bounds).image() { context in
            renderWide(into: context.cgContext, at: center, currentHeight: treeHeight)
        }
    }

    /// Recursively renders the tree into the context.
    private func renderWide(into context: CGContext, at center: CGPoint, currentHeight: Int) {
        guard let attributes = visualAttributes else { return }

        func recurse(child: Self?, offset: CGFloat) {
            guard let child = child else { return }
            let childCenter = CGPoint(x: center.x + offset, y: center.y + attributes.size.height * NodeVisualAttributes.spacingScaleFactor.vertical)
            context.drawLine(from: center, to: childCenter, color: attributes.connectingLineColor, width: NodeVisualAttributes.Default.childLineWidth)
            child.renderWide(into: context, at: childCenter, currentHeight: currentHeight - 1)
        }

        let offset = pow(2, CGFloat(currentHeight - 1)) * attributes.size.width * NodeVisualAttributes.spacingScaleFactor.horizontal / 2
        recurse(child: left, offset: -offset)
        recurse(child: right, offset: offset)

        attributes.color.setFill()
        context.fillEllipse(in: CGRect(center: center, size: attributes.size))
        attributes.text.draw(centeredAt: center, attributes: attributes.textAttributes)
    }

    /// Computes the bounds of the image based on the tree's height.
    /// The tree's height is passed as a parameter to avoid unnecessary recalculation.
    private func wideBounds(forHeight height: Int) -> CGRect {
        guard let attributes = visualAttributes else { return .zero }
        let boundsWidth = pow(2, CGFloat(height)) * attributes.size.width * NodeVisualAttributes.spacingScaleFactor.horizontal
        let boundsHeight = CGFloat(height + 1) * attributes.size.height * NodeVisualAttributes.spacingScaleFactor.vertical
        return CGRect(origin: .zero, size: CGSize(width: boundsWidth, height: boundsHeight))
    }
}

