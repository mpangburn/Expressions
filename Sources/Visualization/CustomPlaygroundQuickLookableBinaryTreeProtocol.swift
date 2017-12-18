//
//  CustomPlaygroundQuickLookableBinaryTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol CustomPlaygroundQuickLookableBinaryTreeProtocol: BinaryTreeProtocol, CustomPlaygroundQuickLookable {
    var visualAttributes: NodeVisualAttributes? { get }
}

extension CustomPlaygroundQuickLookableBinaryTreeProtocol {
    public var visualAttributes: NodeVisualAttributes? {
        guard let kind = kind else { return nil }

        let color: UIColor
        let text: String
        let textAttributes: [NSAttributedStringKey: Any]
        let connectingLineColor: UIColor

        switch kind {
        case let .leaf(value):
            color = NodeVisualAttributes.leafNodeColor
            text = String(describing: value)
            textAttributes = NodeVisualAttributes.leafNodeTextAttributes
            connectingLineColor = NodeVisualAttributes.leafChildLineColor
        case let .node(value):
            color = NodeVisualAttributes.nonLeafNodeColor
            text = String(describing: value)
            textAttributes = NodeVisualAttributes.nonLeafNodeTextAttributes
            connectingLineColor = NodeVisualAttributes.nonLeafChildLineColor
        }

        return NodeVisualAttributes(color: color, text: text, textAttributes: textAttributes, connectingLineColor: connectingLineColor)
    }
}
