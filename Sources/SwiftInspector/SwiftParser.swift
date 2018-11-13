//
//  SwiftParser.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 11/12/18.
//

import Foundation

extension Token {
    var isWhitespace: Bool {
        switch self.type {
        case .whitespace: return true
        default: return false
        }
    }
}

extension Array where Element == Token {
    func strippedWhitespace() -> [Token] {
        let stripped = self.filter { token in
            return !token.isWhitespace
        }
        
        return stripped
    }
}

public class SwiftParser {
    private let lexer: Lexer
    private let parser: Parser
    
    public convenience init() {
        self.init(contentsOfFile: "")
    }
    
    public init(contentsOfFile source: String) {
        self.lexer = Lexer(source: source)
        self.parser = Parser()
    }
    
    public init(pathToFile: String) {
        fatalError("Not implemented")
    }
    
    public func generateAST(fromSource source: String) throws -> Program {
        let tokens = try lexer.scan(source: source)
        return try parser.parse(with: tokens.strippedWhitespace())
    }
    
    public func generateAST() throws -> Program {
        return try parser.parse(with: tokenize())
    }
    
    private func tokenize() throws -> [Token] {
        let tokens = try lexer.scan()
        return tokens.strippedWhitespace()
    }
}
