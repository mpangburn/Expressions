//
//  NodeVisualAttributes.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public struct NodeVisualAttributes {
    let color: UIColor
    let text: String
    let textAttributes: [NSAttributedStringKey: Any]
    let connectingLineColor: UIColor

    static let nodeSize = CGSize(width: 24, height: 24)
    static let nodeSpacingScaleFactor: (horizontal: CGFloat, vertical: CGFloat) = (1.5, 1.5)

    static let leafNodeColor = UIColor.flatBlue
    static let leafNodeTextAttributes: [NSAttributedStringKey: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 12),
        .foregroundColor: UIColor.white
    ]

    static let nonLeafNodeColor = UIColor.flatRed
    static let nonLeafNodeTextAttributes: [NSAttributedStringKey: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 12),
        .foregroundColor: UIColor.white
    ]

    static let leafChildLineColor = NodeVisualAttributes.leafNodeColor
    static let nonLeafChildLineColor = NodeVisualAttributes.nonLeafNodeColor
    static let childLineWidth: CGFloat = 1

    enum SingleTypeTree {
        static let nodeColor = UIColor.flatGreen
        static let nodeTextAttributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.white
        ]
        static let childLineColor = SingleTypeTree.nodeColor
    }
}
