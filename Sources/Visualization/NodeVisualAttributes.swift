//
//  NodeVisualAttributes.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public struct NodeVisualAttributes {
    let size: CGSize
    let color: UIColor
    let text: String
    let textAttributes: [NSAttributedStringKey: Any]
    let connectingLineColor: UIColor

    enum Default {
        static let size = CGSize(width: 24, height: 24)
        static let textAttributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.white
        ]
        static let childLineWidth: CGFloat = 1
    }

    static let spacingScaleFactor: (horizontal: CGFloat, vertical: CGFloat) = (1.5, 1.5)
}
