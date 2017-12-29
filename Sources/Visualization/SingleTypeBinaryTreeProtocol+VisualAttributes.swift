//
//  SingleTypeBinaryTreeProtocol+VisualAttributes.swift
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
