//
//  CombinedExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


protocol CombinedExpression {
    associatedtype HigherExpression: EvaluatableExpressionProtocol
    associatedtype Reducer: BinaryOperatorProtocol where Reducer.Operand == LowerExpression.Result, Reducer.Result == HigherExpression.Operand
    associatedtype LowerExpression: EvaluatableExpressionProtocol
}

enum ComparativeArithmeticExpression<T: FixedWidthIntegerOperandProtocol>: CombinedExpression {
    typealias HigherExpression = LogicalExpression
    typealias Reducer = ComparativeOperator<T>
    typealias LowerExpression = ArithmeticExpression<T>

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

    func test() {
        let expression: ComparativeArithmeticExpression<Int> =
            .combined(
                left: .higher(true),
                operator: .logicalAND,
                right: .lower(
                    left: 1+2,
                    operator: .greaterThan,
                    right: 3/4
                )
            )
    }
}
