//
//  BinaryTreeNodeView.swift
//  Expression
//
//  Created by Michael Pangburn on 12/19/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


/// A view representing a node of a binary tree.
public class BinaryTreeNodeView: UIView {
    public var visualAttributes: NodeVisualAttributes?
    public var childNodeViews: [BinaryTreeNodeView] = []
    public var childLineViews: [LineView] = []
    public var nextLabelText = ""
    public var nextColor = UIColor.clear

    public private(set) lazy var label: UILabel = {
        let label = UILabel(frame: bounds)
        label.textAlignment = .center
        addSubview(label)
        return label
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func bringInChildNodes() {
        func applyShrinkingTranslation(toLineView lineView: LineView, x: CGFloat, y: CGFloat) {
            // Scaling to zero does not produce the desired effect when animated, so use a very small value instead.
            lineView.transform = CGAffineTransform(translationX: x, y: y).scaledBy(x: 0.0001, y: 0.0001)
        }

        switch childNodeViews.count {
        case 0:
            break
        case 1:
            let childNodeView = childNodeViews[0]
            guard let childLineView = childLineViews.first else { fatalError("Mismatch in the counts of child node views and line views.") }
            label.alpha = 0
            childNodeView.frame = frame
            applyShrinkingTranslation(toLineView: childLineView, x: 0, y: -childNodeView.frame.height / 2)
        case 2:
            let (leftNodeView, rightNodeView) = (childNodeViews[0], childNodeViews[1])
            guard let leftLineView = childLineViews.first, let rightLineView = childLineViews.last else {
                fatalError("Mismatch in the counts of child node views and line views.")
            }
            label.alpha = 0
            leftNodeView.frame = frame
            rightNodeView.frame = frame
            applyShrinkingTranslation(toLineView: leftLineView, x: leftLineView.frame.width / 2, y: -leftLineView.frame.height / 2)
            applyShrinkingTranslation(toLineView: rightLineView, x: -rightLineView.frame.width / 2, y: -rightLineView.frame.height / 2)
        default:
            fatalError("A binary tree node cannot have more than two children.")
        }

    }

    public func updateToNextState() {
        guard let attributes = visualAttributes else { return }
        label.attributedText = NSAttributedString(string: nextLabelText, attributes: attributes.textAttributes)
        backgroundColor = nextColor
        for childNodeView in childNodeViews {
            childNodeView.alpha = 0
        }

        UIView.animate(withDuration: 0.5) {
            self.label.alpha = 1
        }
    }
}
