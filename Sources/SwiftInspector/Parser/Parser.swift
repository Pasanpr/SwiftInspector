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
    private var tokens: [Token]
    private var current = 0
    
    private var isAtEnd: Bool {
        return peek().type == .eof
    }
    
    convenience init() {
        self.init(tokens: [])
    }
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    public func parse(with tokens: [Token]) throws -> Program {
        self.tokens = tokens
        return try parse()
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
        if match(types: .keyword(.declaration(.var))) {
            return try varDeclaration()
        } else {
            return try Statement.expression(expression())
        }
    }
    
    private func varDeclaration() throws -> Statement {
        let identifier = try primary()
        
        if match(types: .operator(.assignment)) {
            let rhs = try expression()
            return Statement.declaration(.variable(identifier: identifier, type: nil, expression: rhs))
        } else {
            throw ParserError.expectedAssignmentExpression
        }
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
            return .binary(operator: op, lhs: lhs, rhs: rhs)
        }
        
        return lhs
    }
    
    private func multiplication() throws -> Expression {
        let lhs = try prefix()
        
        while match(types: .operator(.multiplication), .operator(.division), .operator(.remainder)) {
            let op = previous()
            let rhs = try prefix()
            return Expression.binary(operator: op, lhs: lhs, rhs: rhs)
        }
        
        return lhs
    }
    
    private func prefix() throws -> Expression {
        if match(types: .operator(.logicalNot)) {
            let op = previous()
            let rhs = try postfix()
            return Expression.prefix(operator: op, rhs: rhs)
        }
        
        return try Expression.prefix(operator: nil, rhs: postfix())
    }
    
    private func postfix() throws -> PostfixExpression {
        return try PostfixExpression.primary(primary())
    }
    
    private func primary() throws -> PrimaryExpression {
        let type = peek().type
        
        switch type {
        case .identifier(let name):
            let _ = advance()
            return PrimaryExpression.identifier(name, genericArgs: nil)
        case .literal(.integer(let value)):
            let _ = advance()
            return PrimaryExpression.literal(value.description)
        case .literal(.string(let value)):
            let _ = advance()
            return PrimaryExpression.literal(value)
        default:
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
