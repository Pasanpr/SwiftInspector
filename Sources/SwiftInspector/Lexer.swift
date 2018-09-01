//
//  Lexer.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 8/31/18.
//

import Foundation

public enum LexerError: Error {
    case invalidToken
}

public final class Lexer {
    private let source: String
    private var tokens: Array<Token>
    private var start = 0
    public var current = 0
    private var line = 1
    
    var isAtEnd: Bool {
        return current >= source.count
    }
    
    init(source: String) {
        self.source = source
        self.tokens = []
    }
    
    public func scan() throws -> [Token] {
        while !isAtEnd {
            start = current
            let token = try tokenize()
            tokens.append(token)
        }
        
        let token = Token(type: .eof, line: line)
        tokens.append(token)
        return tokens
    }
    
    private func tokenize() throws -> Token {
        let character = advance()
        switch character {
        case "(": return Token(type: .leftParen, line: line)
        case ")": return Token(type: .rightParen, line: line)
        case " ":
            // After the character is consumed by advance(), current is incremented. We started at current - 1
            let startPosition = current - 1
            
            while (peek() == " " && !isAtEnd) {
                let _ = advance()
            }
            let startIndex = source.unicodeScalars.index(source.unicodeScalars.startIndex, offsetBy: startPosition)
            let stopIndex = source.unicodeScalars.index(source.unicodeScalars.startIndex, offsetBy: current)
            
            if startIndex == stopIndex {
                return Token(type: .space(" "), line: line)
            } else {
                let substring = String(source.unicodeScalars[startIndex..<stopIndex])
                return Token(type: .space(substring), line: line)
            }
        default:
            throw LexerError.invalidToken
        }
    }
    
    /// Consume character at `current` position and return it
    ///
    /// Moves current forward after consuming character at `current`
    /// - Returns: UnicodeScalar value at source at position offset by `current`
    public func advance() -> UnicodeScalar {
        // Consume character at current before moving current forward
        let c = character(in: source, atIndexOffsetBy: current)
        current += 1
        return c
    }
    
    private func peek() -> UnicodeScalar {
        if isAtEnd { return "\0" }
        return character(in: source, atIndexOffsetBy: current)
    }
    
    
    /// Returns true if expected scalar matches scalar at current position
    ///
    /// Functions as a conditional advance. Moves current forward only if match
    /// - Parameter expected: Unicode scalar to match
    /// - Returns: true if match
    private func match(expected: UnicodeScalar) -> Bool {
        if isAtEnd { return false }
        
        if character(in: source, atIndexOffsetBy: current) != expected {
            return false
        }
        
        current += 1
        return true
    }
    
    /// Returns character at specified distance from the start of the source string
    ///
    /// - Parameters:
    ///   - source: The string to scan through
    ///   - offset: The distance to the offset index
    /// - Returns: UnicodeScalar at specified index position
    public func character(in source: String, atIndexOffsetBy offset: Int) -> UnicodeScalar {
        let index = source.unicodeScalars.index(source.unicodeScalars.startIndex, offsetBy: offset)
        return source.unicodeScalars[index]
    }
}

