//
//  Evaluatable.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A type that can be evaluated.
public protocol Evaluatable {
    /// The result of the evaluation.
    associatedtype Result

    /// Evaluates the instance and returns the result.
    func evaluate() -> Result
}
