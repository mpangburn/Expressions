//
//  SingleTypeCustomPlaygroundQuickLookableBinaryTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol SingleTypeCustomPlaygroundQuickLookableBinaryTreeProtocol: SingleTypeBinaryTreeProtocol, CustomPlaygroundQuickLookableBinaryTreeProtocol { }

extension SingleTypeCustomPlaygroundQuickLookableBinaryTreeProtocol {
    public var visualAttributes: NodeVisualAttributes? {
        guard let value = value else { return nil }

        let color = NodeVisualAttributes.SingleTypeTree.nodeColor
        let text = String(describing: value)
        let textAttributes = NodeVisualAttributes.SingleTypeTree.nodeTextAttributes
        let connectingLineColor = NodeVisualAttributes.SingleTypeTree.childLineColor

        return NodeVisualAttributes(color: color, text: text, textAttributes: textAttributes, connectingLineColor: connectingLineColor)
    }
}
