//
//  Operator.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/24/18.
//

import Foundation

public enum Operator: AutoEquatable, CaseIterable {
    case assignment
    case addition
    case subtraction
    case multiplication
    case division
    case remainder
    case additionAssignment
    case subtractionAssignment
    case remainderAssignment
    case divisionAssignment
    case multiplicationAssignment
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
    case returnType
    case optional
    case forcedOptional
}

extension Operator: CustomStringConvertible {
    public var description: String {
        switch self {
        case .assignment: return "="
        case .addition: return "+"
        case .subtraction: return "-"
        case .multiplication: return "*"
        case .division: return "/"
        case .remainder: return "%"
        case .additionAssignment: return "+="
        case .subtractionAssignment: return "-="
        case .remainderAssignment: return "%="
        case .divisionAssignment: return "/="
        case .multiplicationAssignment: return "*="
        case .prefixMinus: return "-"
        case .prefixPlus: return "+"
        case .equalTo: return "=="
        case .notEqualTo: return "!="
        case .greaterThan: return ">"
        case .lessThan: return "<"
        case .greaterThanOrEqual: return ">="
        case .lessThanOrEqual: return "<="
        case .identity: return "==="
        case .identityNot: return "!=="
        case .nilCoalescing: return "??"
        case .ternaryConditional: return "?:"
        case .closedRange: return "..."
        case .halfOpenRange: return "..<"
        case .oneSidedRange: return "..."
        case .logicalNot: return "!"
        case .logicalAnd: return "&&"
        case .logicalOr: return "||"
        case .returnType: return "->"
        case .optional: return "?"
        case .forcedOptional: return "!"
        }
    }
}
