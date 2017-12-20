//
//  CombinedExpressionProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


protocol CombinedExpressionProtocol: Evaluatable {
    associatedtype HigherExpression: EvaluatableExpressionProtocol
    associatedtype Reducer: BinaryOperatorProtocol where Reducer.Operand == LowerExpression.Result, Reducer.Result == HigherExpression.Operand
    associatedtype LowerExpression: EvaluatableExpressionProtocol
}

enum ComparativeArithmeticExpression<T: FixedWidthIntegerOperandProtocol>: CombinedExpressionProtocol {

    typealias HigherExpression = LogicalExpression
    typealias Reducer = ComparativeOperator<T>
    typealias LowerExpression = ArithmeticExpression<T>

    typealias Leaf = TreeNode<LowerExpression.Operand, HigherExpression.Operand>
    typealias Node = TreeNode<Reducer, HigherExpression.Operator>

    case lower(left: LowerExpression, operator: Reducer, right: LowerExpression)
    case higher(HigherExpression)
    indirect case combined(left: ComparativeArithmeticExpression<T>, operator: HigherExpression.Operator, right: ComparativeArithmeticExpression<T>)

    func evaluate() -> HigherExpression.Result {
        switch self {
        case let .lower(left, `operator`, right):
            return `operator`.apply(left.evaluate(), right.evaluate())
        case let .higher(expression):
            return expression.evaluate()
        case let .combined(left, `operator`, right):
            return `operator`.apply(left.evaluate(), right.evaluate())
        }
    }
}
