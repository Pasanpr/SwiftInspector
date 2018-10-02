//
//  ASTPrintable.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/28/18.
//

import Foundation

protocol Printable {
    func accept(printer: Printer) -> String
}

protocol Printer {
    func processStatement(_ statement: Statement) -> String
    func processExpression(_ expression: Expression) -> String
    func processPrefixExpression(_ expression: PrefixExpression) -> String
    func processPostfixExpression(_ expression: PostfixExpression) -> String
    func processPrimaryExpression(_ expression: PrimaryExpression) -> String
    func processBinaryExpression(_ expression: BinaryExpression) -> String
}

struct ASTPrinter: Printer {
    func processStatement(_ statement: Statement) -> String {
        switch statement {
        case .expression(let expr): return processExpression(expr)
        }
    }
    
    func processExpression(_ expression: Expression) -> String {
        switch expression {
        case .prefix(let `try`, let prefixExpr, let binaryExpr):
            var output = ""
            
            if let `try` = `try` {
                output += "\(`try`) "
            }
            
            let prefixOutput = processPrefixExpression(prefixExpr)
            output += prefixOutput
            
            if let binaryExpr = binaryExpr {
                let binaryOutput = processBinaryExpression(binaryExpr)
                output += " \(binaryOutput)"
            }
            
            return output
        }
    }
    
    func processPrefixExpression(_ expression: PrefixExpression) -> String {
        switch expression {
        case .inout(let identifier): return "&\(identifier)"
        case .prefix(let op, let rhs):
            let postfixOutput = processPostfixExpression(rhs)
            
            if let op = op { return "\(op.description) \(postfixOutput)" }
            return postfixOutput
        }
    }
    
    func processPostfixExpression(_ expression: PostfixExpression) -> String {
        switch expression {
        case .primary(let primaryExpr): return processPrimaryExpression(primaryExpr)
        default: return ""
        }
    }
    
    func processBinaryExpression(_ expression: BinaryExpression) -> String {
        switch expression {
        case .prefix(let op, let binaryExpr, let prefixExpr):
            let prefixOutput = processPrefixExpression(prefixExpr)
            
            if let binaryExpr = binaryExpr {
                let binaryExprOutput = processBinaryExpression(binaryExpr)
                return "\(op.type) \(binaryExprOutput) \(prefixOutput)"
            } else {
                return "\(op.type) \(prefixOutput)"
            }
        }
    }
    
    func processPrimaryExpression(_ expression: PrimaryExpression) -> String {
        switch expression {
        case .literal(let value): return value
        default: return "implement"
        }
    }
}
