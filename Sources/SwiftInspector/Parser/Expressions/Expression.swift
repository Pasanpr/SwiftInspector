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

enum Expression {
    case prefix(try: Bool?, expression: PrefixExpression, binaryExpression: BinaryExpression?)
}

extension Expression: Printable {
    func accept(printer: Printer) -> String {
        return printer.processExpression(self)
    }
}
