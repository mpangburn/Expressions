//
//  BinaryOperatorPrecedence.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// Contains the possible values for a binary operator's precedence,
/// which is used to determine the order of operations when combined with other operators.
/// c.f. https://developer.apple.com/documentation/swift/operator_declarations
public enum BinaryOperatorPrecedence: Int, Comparable {
    case assignment
    case ternary
    case logicalDisjunction
    case logicalConjunction
    case comparison
    case nilCoalescing
    case casting
    case rangeFormation
    case addition
    case multiplication
    case bitwiseShift

    public static func < (lhs: BinaryOperatorPrecedence, rhs: BinaryOperatorPrecedence) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
