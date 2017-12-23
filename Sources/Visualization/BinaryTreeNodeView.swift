//
//  BinaryTreeNodeView.swift
//  Expression
//
//  Created by Michael Pangburn on 12/19/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


public class BinaryTreeNodeView: UIView {

    public var visualAttributes: NodeVisualAttributes? { didSet { setNeedsDisplay() } }
    public var childNodeViews: [BinaryTreeNodeView] = []
    public var childLineViews: [LineView] = []
    public var nextLabelText = ""
    public var nextColor: UIColor = .clear

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
        guard let leftNodeView = childNodeViews.first, let rightNodeView = childNodeViews.last, let leftLineView = childLineViews.first, let rightLineView = childLineViews.last else { return }
        label.alpha = 0
        leftNodeView.frame = frame
        rightNodeView.frame = frame
        leftLineView.transform = CGAffineTransform(translationX: leftLineView.frame.width / 2, y: -leftLineView.frame.height / 2).scaledBy(x: 0.0001, y: 0.0001)
        rightLineView.transform = CGAffineTransform(translationX: -rightLineView.frame.width / 2, y: -rightLineView.frame.height / 2).scaledBy(x: 0.0001, y: 0.0001)
    }

    public func updateToNextState() {
        guard let attributes = visualAttributes else { return }
        label.attributedText = NSAttributedString(string: self.nextLabelText, attributes: attributes.textAttributes)
        backgroundColor = nextColor
        if let left = childNodeViews.first, let right = childNodeViews.last {
            left.alpha = 0
            right.alpha = 0
        }

        UIView.animate(withDuration: 0.5, animations: {
            self.label.alpha = 1
        })
    }
}
