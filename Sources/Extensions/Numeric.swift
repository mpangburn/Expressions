//
//  Numeric.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


extension Numeric {
    // Would expect these to have default implementations
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    public static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
}
