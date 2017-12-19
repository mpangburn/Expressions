//
//  Evaluatable.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import CoreGraphics


/// A type that can be evaluated.
public protocol Evaluatable {

    /// The result of the evaluation.
    associatedtype Result

    /// Evaluates the instance and returns the result.
    func evaluate() -> Result
}

extension Evaluatable where Self: Numeric {
    public func evaluate() -> Magnitude {
        return magnitude
    }
}

extension Int: Evaluatable { }
extension Int8: Evaluatable { }
extension Int16: Evaluatable { }
extension Int32: Evaluatable { }
extension Int64: Evaluatable { }

extension UInt: Evaluatable { }
extension UInt8: Evaluatable { }
extension UInt16: Evaluatable { }
extension UInt32: Evaluatable { }
extension UInt64: Evaluatable { }

extension Double: Evaluatable { }
extension Float: Evaluatable { }
extension Float80: Evaluatable { }
extension CGFloat: Evaluatable { }
