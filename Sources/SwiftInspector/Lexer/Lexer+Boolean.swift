//
//  Lexer+Boolean.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 2/11/19.
//

import Foundation

extension Lexer {
    func booleanLiteral(withLexeme lexeme: String) -> Token? {
        switch lexeme {
        case "true": return Token(type: .literal(.boolean(true)), line: line)
        case "false": return Token(type: .literal(.boolean(false)), line: line)
        default: return nil
        }
    }
}
