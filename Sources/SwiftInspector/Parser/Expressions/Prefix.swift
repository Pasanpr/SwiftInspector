//
//  Prefix.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

/*
 Prefix Expressions
 
 prefix-expression → prefix-operator(opt) postfix-expression
 prefix-expression → in-out-expression
 in-out-expression → & identifier
 */

public enum PrefixExpression {
    case prefix(operator: Token?, rhs: PostfixExpression)
    case `inout`(identifier: String)
}

extension PrefixExpression: AutoEquatable {}

extension PrefixExpression: Printable {
    func accept(printer: Printer) -> String {
        return printer.processPrefixExpression(self)
    }
}
