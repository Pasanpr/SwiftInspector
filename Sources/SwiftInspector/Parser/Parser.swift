//
//  Parser.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

enum ParserError: Error {
    case expectedPrimaryExpression
    case expectedAssignmentExpression
}

class Parser {
    let tokens: [Token]
    var current = 0
    
    var isAtEnd: Bool {
        return peek().type == .eof
    }
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    func parse() throws -> Program {
        do {
            let stmt = try statement()
            return Program(statements: [stmt])
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    private func statement() throws -> Statement {
        return try Statement.expression(expression())
    }
    
    private func expression() throws -> Expression {
        return try addition()
    }
    
    // Right associative
//    private func assignment() throws -> BinaryExpression {
//
//        while match(types: .operator(.subtractionAssignment), .operator(.additionAssignment), .operator(.remainderAssignment), .operator(.divisionAssignment), .operator(.multiplicationAssignment), .operator(.assignment)) {
//            let rhs = try ternary()
//            return BinaryExpression.assignment(try: nil, rhs: rhs)
//        }
//
//        throw ParserError.expectedAssignmentExpression
//    }
//
//    private func ternary() throws -> BinaryExpression {
//        return try logicalOr()
//    }
//
//    private func logicalOr() throws -> BinaryExpression {
//        return try logicalAnd()
//    }
//
//    private func logicalAnd() throws -> BinaryExpression {
//        return try comparison()
//    }
//
//    private func comparison() throws -> BinaryExpression {
//        return try nilCoalescing()
//    }
//
//    private func nilCoalescing() throws -> BinaryExpression {
//        return try casting()
//    }
//
//    private func casting() throws -> BinaryExpression {
//        return try addition()
//    }
    
    private func addition() throws -> Expression {
        let lhs = try multiplication()
        
        while match(types: .operator(.addition), .operator(.subtraction)) {
            let op = previous()
            let rhs = try multiplication()
            return Expression.binary(BinaryExpression.binary(operator: op, lhs: lhs, rhs: rhs))
        }
        
        return lhs
    }
    
    private func multiplication() throws -> Expression {
        let lhs = try prefix()
        
        while match(types: .operator(.multiplication), .operator(.division), .operator(.remainder)) {
            let op = previous()
            let rhs = try prefix()
            return Expression.binary(BinaryExpression.prefix(operator: op, lhs: lhs, rhs: rhs))
        }
        
        return Expression.prefix(lhs)
    }
    
    private func prefix() throws -> PrefixExpression {
        if match(types: .operator(.logicalNot)) {
            let op = previous()
            let rhs = try postfix()
            return PrefixExpression.prefix(operator: op, rhs: rhs)
        }
        
        return try PrefixExpression.prefix(operator: nil, rhs: postfix())
    }
    
    private func postfix() throws -> PostfixExpression {
        return try PostfixExpression.primary(primary())
    }
    
    private func primary() throws -> PrimaryExpression {
        if case .literal(.integer(let value)) = peek().type {
            let _ = advance()
            return PrimaryExpression.literal(value.description)
        } else {
            throw ParserError.expectedPrimaryExpression
        }
    }
    
    private func match(types: TokenType...) -> Bool {
        for type in types {
            if check(type: type) {
                let _ = advance()
                return true
            }
        }
        
        return false
    }
    
    private func check(type: TokenType) -> Bool {
        if isAtEnd { return false }
        return peek().type == type
    }
    
    private func advance() -> Token {
        if !isAtEnd { current += 1 }
        return previous()
    }
    
    private func previous() -> Token {
        return tokens[current - 1]
    }
    
    private func peek() -> Token {
        return tokens[current]
    }
}
