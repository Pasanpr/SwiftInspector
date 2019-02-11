//
//  Lexer+Punctuation.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 2/11/19.
//

import Foundation

public extension Lexer {
    func punctuation(character: UnicodeScalar, line: Int) -> Token {
        switch character {
        case "(": return Token(type: .punctuation(.leftParen), line: line)
        case ")": return Token(type: .punctuation(.rightParen), line: line)
        case "{": return Token(type: .punctuation(.leftCurlyBracket), line: line)
        case "}": return Token(type: .punctuation(.rightCurlyBracket), line: line)
        default: fatalError()
        }
    }
}
