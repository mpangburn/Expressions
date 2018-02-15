//
//  OperatorNodeKind.swift
//  Expression
//
//  Created by Michael Pangburn on 12/27/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// The kind of an operator node--either a unary or a binary operator.
public enum OperatorNodeKind<UnaryOperator: UnaryOperatorProtocol, BinaryOperator: BinaryOperatorProtocol> {
    case unary(UnaryOperator)
    case binary(BinaryOperator)
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
