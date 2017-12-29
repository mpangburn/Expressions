//
//  CustomVisualAttributes.swift
//  Expression
//
//  Created by Michael Pangburn on 12/19/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


extension SingleTypeBinaryTreeProtocol where Self: CustomPlaygroundQuickLookableBinaryTreeProtocol {
    public var visualAttributes: NodeVisualAttributes? {
        guard let value = value else { return nil }

        let size = NodeVisualAttributes.Default.size
        let color = UIColor.flatGreen
        let text = String(describing: value)
        let textAttributes = NodeVisualAttributes.Default.textAttributes
        let connectingLineColor = color

        return NodeVisualAttributes(size: size, color: color, text: text, textAttributes: textAttributes, connectingLineColor: connectingLineColor)
    }
}

extension FloatingPointArithmeticExpression {
    public var visualAttributes: NodeVisualAttributes? {
        let size = CGSize(width: 32, height: 32)
        let color: UIColor
        let text: String
        let textAttributes = NodeVisualAttributes.Default.textAttributes

        switch neverEmptyNodeKind {
        case let .leaf(value):
            color = .flatBlue
            let displayValue = (value * 10).rounded() / 10
            text = String(describing: displayValue)
        case let .node(value):
            color = .flatRed
            text = String(describing: value)
        }

        let connectingLineColor = color

        return NodeVisualAttributes(size: size, color: color, text: text, textAttributes: textAttributes, connectingLineColor: connectingLineColor)
    }
}

extension LogicalExpression {
    public var visualAttributes: NodeVisualAttributes? {
        let size = CGSize(width: 36, height: 36)
        let color: UIColor
        let text: String
        let textAttributes = NodeVisualAttributes.Default.textAttributes

        switch neverEmptyNodeKind {
        case let .leaf(value):
            color = value ? .flatGreen2 : .flatRed2
            text = String(describing: value)
        case let .node(value):
            color = .flatBlue2
            text = String(describing: value)
        }

        let connectingLineColor = color

        return NodeVisualAttributes(size: size, color: color, text: text, textAttributes: textAttributes, connectingLineColor: connectingLineColor)
    }
}

extension BinarySearchTree: CustomPlaygroundQuickLookableBinaryTreeProtocol { }

extension RedBlackTree: CustomPlaygroundQuickLookableBinaryTreeProtocol {
    public var visualAttributes: NodeVisualAttributes? {
        guard case let .node(color, _, value, _) = self else { return nil }
        let uiColor: UIColor
        switch color {
        case .red:
            uiColor = .red
        case .black:
            uiColor = .black
        }

        let size = NodeVisualAttributes.Default.size
        let text = String(describing: value)
        let textAttributes = NodeVisualAttributes.Default.textAttributes

        return NodeVisualAttributes(size: size, color: uiColor, text: text, textAttributes: textAttributes, connectingLineColor: uiColor)
    }
}
