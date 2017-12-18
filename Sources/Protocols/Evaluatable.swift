//
//  Evaluatable.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol Evaluatable {
    associatedtype Result
    func evaluate() -> Result
}
