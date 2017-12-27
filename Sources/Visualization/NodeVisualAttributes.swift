//
//  NodeVisualAttributes.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// The visual attributes of a node to be used in rendering the image of a tree.
public struct NodeVisualAttributes {
    public let size: CGSize
    public let color: UIColor
    public let text: String
    public let textAttributes: [NSAttributedStringKey: Any]
    public let connectingLineColor: UIColor

    public var childLineWidth: CGFloat {
        return (1 / Default.size.width) * size.width
    }

    public enum Default {
        public static let size = CGSize(width: 24, height: 24)
        public static let textAttributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.white
        ]
    }

    public static let spacingScaleFactor: (horizontal: CGFloat, vertical: CGFloat) = (1.5, 1.5)
}
