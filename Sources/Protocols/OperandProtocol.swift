//
//  OperandProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import CoreGraphics


// These typealiases parallel the Operand constraints for the Operator protocols
public typealias NumericOperandProtocol = Numeric & Comparable & _ExpressibleByBuiltinIntegerLiteral
public typealias DivisibleOperandProtocol = NumericOperandProtocol & Divisible
public typealias BinaryIntegerOperandProtocol = DivisibleOperandProtocol & BinaryInteger
public typealias FixedWidthIntegerOperandProtocol = BinaryIntegerOperandProtocol & FixedWidthInteger
public typealias FloatingPointOperandProtocol = DivisibleOperandProtocol & FloatingPoint & _ExpressibleByBuiltinFloatLiteral
