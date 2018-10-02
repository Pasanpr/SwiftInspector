//
//  Expression.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/26/18.
//

import Foundation

/*
 Grammar of an Expression
 
 expression -> try-operator(opt) prefix-expression binary-expressions(opt)
 expression-list -> expression | expression , expression-list
 
 GRAMMAR OF A TRY EXPRESSION
 
 try-operator → try | try ? | try !
*/

public enum Expression {
    case prefixBinary(try: Bool?, lhs: PrefixExpression, operator: Token, rhs: PrefixExpression)
    
    
    case prefix(PrefixExpression)
    case binary(BinaryExpression)
}

extension Expression: AutoEquatable {}
