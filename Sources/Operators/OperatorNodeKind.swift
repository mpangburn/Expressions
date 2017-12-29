//
//  OperatorNodeKind.swift
//  Expression
//
//  Created by Michael Pangburn on 12/27/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// The kind of an operator node--either a unary or a binary operator.
public enum OperatorNodeKind<UnaryOperator: UnaryOperatorProtocol, BinaryOperator: BinaryOperatorProtocol> {
    case unary(UnaryOperator)
    case binary(BinaryOperator)
}

extension OperatorNodeKind: Equatable {
    public static func == <A, B> (lhs: OperatorNodeKind<A, B>, rhs: OperatorNodeKind<A, B>) -> Bool {
        switch (lhs, rhs) {
        case let (.unary(leftOperator), .unary(rightOperator)):
            return leftOperator == rightOperator
        case let (.binary(leftOperator), .binary(rightOperator)):
            return leftOperator == rightOperator
        case (.unary, _):
            return false
        case (.binary, _):
            return false
        }
    }
}

extension OperatorNodeKind: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .unary(`operator`):
            return String(describing: `operator`)
        case let .binary(`operator`):
            return String(describing: `operator`)
        }
    }
}
