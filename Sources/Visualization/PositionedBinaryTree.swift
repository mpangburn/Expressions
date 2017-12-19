//
//  PositionedBinaryTree.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A wrapper around a binary tree to store its logical x- and y-coordinates for positioning in space.
class PositionedBinaryTree<T: CustomPlaygroundQuickLookableBinaryTreeProtocol> {
    /// The tree to position.
    let tree: T

    /// The logical x-coordinate of the tree in space once positioned.
    var x: Int

    /// The logical y-coordinate of the tree in space once positioned.
    var y: Int

    /// The positioned children of the wrapped tree.
    var children: [PositionedBinaryTree<T>]

    private init(tree: T, depth: Int) {
        self.tree = tree
        self.x = -1
        self.y = depth
        self.children = []
    }
}

extension PositionedBinaryTree {
    /// Positions the tree using a naive O(_n^2_) implementation of Reingold and Tilford's algorithm.
    /// c.f. https://llimllib.github.io/pymag-trees/
    static func reingoldTilford(tree: T, depth: Int = 0) -> PositionedBinaryTree<T> {
        let positionedTree = PositionedBinaryTree(tree: tree, depth: depth)
        switch (tree.left, tree.right) {
        case (nil, nil):
            positionedTree.x = 0
        case let (.some(singleChild), nil):
            positionedTree.children = [reingoldTilford(tree: singleChild, depth: depth + 1)]
            positionedTree.x = positionedTree.children.first!.x
        case let (nil, .some(singleChild)): // Swift does not yet support combining this with the above case.
            positionedTree.children = [reingoldTilford(tree: singleChild, depth: depth + 1)]
            positionedTree.x = positionedTree.children.first!.x
        case let (.some(leftChild), .some(rightChild)):
            let left = reingoldTilford(tree: leftChild, depth: depth + 1)
            let right = reingoldTilford(tree: rightChild, depth: depth + 1)
            positionedTree.children = [left, right]
            positionedTree.x = computeNodePosition(fromLeft: left, right: right)
        }

        return positionedTree
    }

    /// Computes the position for a node based on its left and right subtrees.
    static func computeNodePosition<T>(fromLeft left: PositionedBinaryTree<T>, right: PositionedBinaryTree<T>) -> Int {
        let leftContour = left.computeContour(.left)    // An array containing the leftmost coordinate at each level.
        let rightContour = right.computeContour(.right) // An array containing the rightmost coordinate at each level.

        var rightOffset = zip(leftContour, rightContour)
            .map { $0 - $1 }    // Map to the distances between the left and right subtrees at each level.
            .max()!             // Find the maximum distance between the left and right subtrees over all levels.
            + 1                 // Add 1 to the offset so the right subtree does not overlap the left subtree when shifted.

        // Add an additional 1 if the midpoint between the left and right is odd.
        // This ensures that all nodes have integral x-coordinates with no loss of precision.
        rightOffset += (right.x + rightOffset + left.x) % 2

        // Shift the whole right subtree by the computed offset.
        right.shiftXCoordinates(by: rightOffset)

        // Return the midpoint of the left and right trees' positions.
        return (left.x + right.x) / 2
    }

    /// The contour of a tree is a list of the maximum or minimum coordinates of a side of the tree.
    enum ContourDirection {
        /// The left contour is found by tracing down the left side of the tree. It contains the minimum x-coordinate at each level.
        case left

        /// The right contour is found by tracing down the right side of the tree. It contains the maximum x-coordinate at each level.
        case right
    }

    /// Computes the tree's contour in a given direction.
    func computeContour(_ contourDirection: ContourDirection, level: Int = 0, contour: [Int] = []) -> [Int] {
        let compare: (Int, Int) -> Bool = (contourDirection == .left) ? (<) : (>)
        var contour = contour
        if contour.count < level + 1 {
            // This is the first node encountered at this depth, so append its x-coordinate to the list.
            contour.append(x)
        } else if compare(contour[level], x) {
            // This node's x-coordinate trumps the previously-recorded coordinate for this depth, so replace it.
            contour[level] = x
        }

        children.forEach { child in
            contour = child.computeContour(contourDirection, level: level + 1, contour: contour)
        }

        return contour
    }

    /// Shifts the x-coordinate of each node in the tree by the value.
    func shiftXCoordinates(by value: Int) {
        x += value
        children.forEach { $0.shiftXCoordinates(by: value) }
    }
}

extension PositionedBinaryTree {
    /// The visual attributes of the positioned tree, taken from the tree model it wraps.
    var visualAttributes: NodeVisualAttributes? {
        return tree.visualAttributes
    }

    /// Compute the bounds for the image of the tree based on the positions of its nodes.
    func bounds() -> CGRect {
        let points = cgPointPositions()
        let xCoordinates = points.map { $0.x }
        let yCoordinates = points.map { $0.y }
        let horizontalOffset = NodeVisualAttributes.nodeSize.width / 2 * NodeVisualAttributes.nodeSpacingScaleFactor.horizontal
        let verticalOffset = NodeVisualAttributes.nodeSize.height / 2 * NodeVisualAttributes.nodeSpacingScaleFactor.vertical
        let topLeft = CGPoint(x: xCoordinates.min()! - horizontalOffset, y: yCoordinates.min()! - verticalOffset)
        let bottomRight = CGPoint(x: xCoordinates.max()! + horizontalOffset, y: yCoordinates.max()! + verticalOffset)
        return CGRect(topLeft: topLeft, bottomRight: bottomRight)
    }

    /// Returns a list of the CGPoints representing the centers of all the nodes in the tree.
    func cgPointPositions() -> [CGPoint] {
        return [cgPointPosition] + children.flatMap { $0.cgPointPositions() }
    }

    /// Translates the logical position of the tree into a CGPoint representing the center of the node.
    var cgPointPosition: CGPoint {
        let scaledX = CGFloat(x) * NodeVisualAttributes.nodeSize.width * NodeVisualAttributes.nodeSpacingScaleFactor.horizontal
        let scaledY = CGFloat(y) * NodeVisualAttributes.nodeSize.height * NodeVisualAttributes.nodeSpacingScaleFactor.vertical
        return CGPoint(x: scaledX, y: scaledY)
    }
}

extension PositionedBinaryTree: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        return "\(tree) at (\(x), \(y))"
    }

    var debugDescription: String {
        return debugDescription()
    }

    /// Generates the debug description, using the tree's depth as a guide for indentation.
    private func debugDescription(depth: Int = 0) -> String {
        var debugDescription = description
        if !children.isEmpty {
            let tabs = String(repeating: "\t", count: depth)
            debugDescription += "\n\(tabs)children:\n"
            for child in children {
                debugDescription += "\(tabs)\t\(child.debugDescription(depth: depth + 1))\n"
            }
        }
        return debugDescription
    }
}
