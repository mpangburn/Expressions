//
//  BinaryOperatorAssociativity.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// Contains the possible values for a binary operator's associativity,
/// which determines how operators of the same precedence are grouped in the absence of parentheses.
public enum BinaryOperatorAssociativity {
    case left
    case right
    case none
}
