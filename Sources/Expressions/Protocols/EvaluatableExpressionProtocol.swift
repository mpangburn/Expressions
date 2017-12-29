//
//  EvaluatableExpressionProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


/// A type representing an evaluatable expression, e.g. arithmetic or logical.
public protocol EvaluatableExpressionProtocol: CustomPlaygroundQuickLookableBinaryTreeProtocol, NeverEmptyTreeProtocol, Evaluatable, CustomStringConvertible where Result == Leaf {

    /// The type of the operands used in the expression.
    typealias Operand = Leaf

    associatedtype UnaryOperator: UnaryOperatorProtocol where UnaryOperator.Operand == Operand, UnaryOperator.Result == Operand

    associatedtype BinaryOperator: BinaryOperatorProtocol where BinaryOperator.Operand == Operand, BinaryOperator.Result == Operand

    /// Returns an expression consisting of the single operand.
    /// - Parameter operand: The operand used to create the expression.
    /// - Returns: An expression consisting of the single operand.
    static func makeExpression(operand: Operand) -> Self

    /// Returns an expression consisting of a unary operator applied to an expression.
    /// - Parameters:
    ///     - unaryOperator: The operator to apply to the expression.
    ///     - expression: The expression to which to apply the operator.
    /// - Returns: An expression consisting of a unary operator applied to an expression.
    static func makeExpression(unaryOperator: UnaryOperator, expression: Self) -> Self

    /// Returns an expression consisting of the left expression and the right expression combined by the operator.
    /// - Parameters:
    ///     - left: The left side of the expression.
    ///     - binaryOperator: The operator combining the two sides of the expression.
    ///     - right: The right side of the expression.
    /// - Returns: An expression consisting of the left expression and the right expression combined by the operator.
    static func makeExpression(left: Self, binaryOperator: BinaryOperator, right: Self) -> Self

    var expressionNodeKind: ExpressionNodeKind<UnaryOperator, BinaryOperator> { get }

    /// The text and color of an evaluated node, for use in displaying in the animated evaluation of the expression.
    /// Defaults to the `visualAttributes.text` and `visualAttributes.color` properties of an operand created
    /// from the evaluation of the expression.
    var evaluatedNodeAttributes: (text: String, color: UIColor) { get }

    /// Determines whether operands should be spaced from their operators in the expression's description.
    /// Defaults to false.
    var shouldSpaceDescription: Bool { get }
}

// MARK: - Default implementations

extension EvaluatableExpressionProtocol {
    public typealias Node = OperatorNodeKind<UnaryOperator, BinaryOperator>

    public var neverEmptyNodeKind: NeverEmptyTreeNode<Leaf, Node> {
        switch expressionNodeKind {
        case let .operand(operand):
            return .leaf(operand)
        case let .unaryOperator(`operator`):
            return .node(.unary(`operator`))
        case let .binaryOperator(`operator`):
            return .node(.binary(`operator`))
        }
    }

    public func evaluate() -> Operand {
        switch expressionNodeKind {
        case let .operand(operand):
            return operand
        case let .unaryOperator(`operator`):
            switch (left, right) {
            case (.none, .none), (.some, .some):
                fatalError("A unary operator must have exactly one operand.")
            case let (.some(expression), .none):
                return `operator`.apply(expression.evaluate())
            case let (.none, .some(expression)):
                return `operator`.apply(expression.evaluate())
            }
        case let .binaryOperator(`operator`):
            guard let left = left, let right = right else { fatalError("A binary operator must have two operands.") }
            return `operator`.apply(left.evaluate(), right.evaluate())
        }
    }

    public var evaluatedNodeAttributes: (text: String, color: UIColor) {
        let result = evaluate()
        guard let attributes = Self.makeExpression(operand: result).visualAttributes else { fatalError("A single operand must have visual attributes.") }
        return (attributes.text, attributes.color)
    }

    public var shouldSpaceDescription: Bool {
        return false
    }
}

extension EvaluatableExpressionProtocol where Self: Equatable {
    /// Tests the expressions for effective equality.
    /// To test equality of underlying tree structures, use the instance method `deepEquals(_:)`.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.description == rhs.description
    }

    /// Tests the underlying tree structures of the two expressions for equality.
    /// - Parameter other: The expression with which to test for equality.
    /// - Returns: A boolean value representing whether the two expressions are deeply equal.
    public func deepEquals(_ other: Self) -> Bool {
        return neverEmptyNodeKind == other.neverEmptyNodeKind && children == other.children
    }
}

// TODO: Consider associativity
extension EvaluatableExpressionProtocol {
    public var description: String {
        switch expressionNodeKind {
        case let .operand(operand):
            return String(describing: operand)
        case let .unaryOperator(`operator`):
            let subexpression: Self
            switch (left, right) {
            case (.none, .none), (.some, .some):
                fatalError("A unary operator must have exactly one operand.")
            case let (.some(expression), .none):
                subexpression = expression
            case let (.none, .some(expression)):
                subexpression = expression
            }

            if case .binaryOperator = subexpression.expressionNodeKind {
                return "\(`operator`)(\(subexpression))"
            } else {
                return "\(`operator`)\(subexpression)"
            }
        case let .binaryOperator(`operator`):
            guard let left = left, let right = right else { fatalError("A binary operator must have two operands.") }
            
            let leftString: String
            if case let .binaryOperator(leftOperator) = left.expressionNodeKind, leftOperator.precedence < `operator`.precedence {
                leftString = "(\(left.description))"
            } else {
                leftString = left.description
            }

            let rightString: String
            if case let .binaryOperator(rightOperator) = right.expressionNodeKind, rightOperator.precedence < `operator`.precedence {
                rightString = "(\(right.description))"
            } else {
                rightString = right.description
            }

            if shouldSpaceDescription {
                return "\(leftString) \(`operator`) \(rightString)"
            } else {
                return "\(leftString)\(`operator`)\(rightString)"
            }
        }
    }
}
