//
//  Either.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// Traditional two-typed `Either` enum, but renamed for clarity with use in a tree.
public enum Either<A: Equatable, B: Equatable> { // TODO: Remove Equatable dependency with conditional conformance
    case leaf(A)
    case node(B)
}

extension Either: Equatable /* where A: Equatable, B: Equatable */ {
    public static func == <A, B> (lhs: Either<A, B>, rhs: Either<A, B>) -> Bool {
        switch (lhs, rhs) {
        case let (.leaf(leftValue), .leaf(rightValue)):
            return leftValue == rightValue
        case let (.node(leftValue), .node(rightValue)):
            return leftValue == rightValue
        case (.leaf, .node):
            return false
        case (.node, .leaf):
            return false
        }
    }
}
