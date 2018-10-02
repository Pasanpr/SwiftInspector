//
//  Parser.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

enum ParserError: Error {
    case expectedPrimaryExpression
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
    
    func parse() throws -> Statement {
        do {
            return try statement()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    private func statement() throws -> Statement {
        return try expression()
    }
    
    private func expression() throws -> Expression {
        return try binaryExpression()
    }
    
    private func binaryExpression() throws -> Expression {
        return try addition()
    }
    
    private func addition() throws -> Expression {
        var binaryExpression = try prefix()
        
        while match(types: .operator(.addition), .operator(.subtraction)) {
            let op = previous()
            let rhs = try prefix()
            binaryExpression = BinaryExpression(lhs: binaryExpression, operator: op, rhs: rhs)
        }
        
        return binaryExpression
    }
    
    private func prefix() throws -> Expression {
        if match(types: .operator(.logicalNot)) {
            let op = previous()
            let rhs = try prefix()
            return PrefixExpression(operator: op, rhs: rhs)
        }
        
        return try primary()
    }
    
    private func primary() throws -> Expression {
        if case .literal(.integer(let value)) = peek().type {
            let _ = advance()
            return PrimaryExpression(literal: value.description)
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
