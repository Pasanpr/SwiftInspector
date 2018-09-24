//
//  Operator.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/24/18.
//

import Foundation

public enum Operator: AutoEquatable {
    case assignment
    case addition
    case subtraction
    case multiplication
    case division
    case remainder
    case additionAssignment
    case subtractionAssignment
    case prefixMinus // not implemented
    case prefixPlus // not implemented
    case equalTo
    case notEqualTo
    case greaterThan
    case lessThan
    case greaterThanOrEqual
    case lessThanOrEqual
    case identity
    case identityNot
    case nilCoalescing
    case ternaryConditional // not implemented
    case closedRange
    case halfOpenRange
    case oneSidedRange // not implemented
    case logicalNot // not implemented
    case logicalAnd
    case logicalOr
}
