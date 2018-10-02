//
//  Postfix.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

/*
 GRAMMAR OF A POSTFIX EXPRESSION
 
 postfix-expression → primary-expression
 postfix-expression → postfix-expression postfix-operator
 postfix-expression → function-call-expression
 postfix-expression → initializer-expression
 postfix-expression → explicit-member-expression
 postfix-expression → postfix-self-expression
 postfix-expression → subscript-expression
 postfix-expression → forced-value-expression
 postfix-expression → optional-chaining-expression
 */

public enum PostfixExpression {
    case primary(PrimaryExpression)
    indirect case postfix(expression: PostfixExpression, operator: Token)
    case functionCall
    case initializer
    case explicitMember
    case postfixSelf
    case `subscript`
    case forcedValue
    case optionalChaining
}

extension PostfixExpression: AutoEquatable {}

extension PostfixExpression: CustomStringConvertible {
    public var description: String {
        switch self {
        case .primary(let expr): return expr.description
        case .postfix(let expression, let `operator`): return "implement"
        default: return "implement"
        }
    }
}
