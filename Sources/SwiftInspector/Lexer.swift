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
        case "\n":
            self.line += 1
            return Token(type: .whitespace(.lineBreak(.newline)), line: line - 1)
        case "(": return Token(type: .punctuation(.leftParen), line: line)
        case ")": return Token(type: .punctuation(.rightParen), line: line)
        case "{": return Token(type: .punctuation(.leftCurlyBracket), line: line)
        case "}": return Token(type: .punctuation(.rightCurlyBracket), line: line)
        case ".": return Token(type: .punctuation(.dot), line: line)
        case ",": return Token(type: .punctuation(.comma), line: line)
        case ":": return Token(type: .punctuation(.colon), line: line)
        case ";": return Token(type: .punctuation(.semicolon), line: line)
        case "/":
            if match(expected: "/") {
                while (peek() != "\n" && !isAtEnd) {
                    let _ = advance()
                }
                
                let substring = substringInSource(from: start, to: current)
                return Token(type: .whitespace(.comment(substring)), line: line)
            } else if match(expected: "*") {
                while (peek() != "*" && peekNext() != "/" && !isAtEnd) {
                    let _ = advance()
                }
                
                // At loop end current points to the last character before the trailing comment marker.
                // Move it forward to the end of the marker
                let _ = advance(by: 2)
                
                let substring = substringInSource(from: start, to: current)
                return Token(type: .whitespace(.multiLineComment(substring)), line: line)
            } else {
                return Token(type: .slash, line: line)
            }
        case " ":
            while (peek() == " " && !isAtEnd) {
                let _ = advance()
            }
            
            return Token(type: .whitespace(.whitespaceItem(.space)), line: line)
        default:
            if isKeyword(character) {
                while (!isAtEnd && !isWhitespace(peek())) {
                    let _ = advance()
                }
                
                let lexeme = substringInSource(from: start, to: current)
                if let declaration = Keyword.Declaration(rawValue: lexeme) {
                    return Token(type: .keyword(.declaration(declaration)), line: line)
                } else if let expression = Keyword.Expression(rawValue: lexeme) {
                    return Token(type: .keyword(.expression(expression)), line: line)
                } else if let statement = Keyword.Statement(rawValue: lexeme) {
                   return Token(type: .keyword(.statement(statement)), line: line)
                } else if let pound = Keyword.Pound(rawValue: lexeme) {
                    return Token(type: .keyword(.pound(pound)), line: line)
                } else {
                    fatalError()
                }
            } else {
                throw LexerError.invalidToken
            }
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
    
    public func advance(by i: Int) -> UnicodeScalar {
        let c = character(in: source, atIndexOffsetBy: current)
        current += i
        return c
    }
    
    private func peek() -> UnicodeScalar {
        return peek(forwardBy: current)
    }
    
    private func peekNext() -> UnicodeScalar {
        return peek(forwardBy: current + 1)
    }
    
    private func peek(forwardBy i: Int) -> UnicodeScalar {
        if isAtEnd { return "\0" }
        return character(in: source, atIndexOffsetBy: i)
    }
    
    
    /// Returns true if expected scalar matches scalar at next position
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
    
    public func substringInSource(from start: Int, to end: Int) -> String {
        let startIndex = source.index(source.startIndex, offsetBy: start)
        let endIndex = source.index(source.startIndex, offsetBy: end)
        return String(source[startIndex..<endIndex])
    }
    
    public func isKeyword(_ c: UnicodeScalar) -> Bool {
        let letters = CharacterSet.uppercaseLetters.union(.lowercaseLetters)
        let underscoreSet = CharacterSet(charactersIn: "#")
        let combinedSet = letters.union(underscoreSet)
        return combinedSet.contains(c)
    }
    
    public func isWhitespace(_ c: UnicodeScalar) -> Bool {
        let set = CharacterSet.whitespacesAndNewlines
        return set.contains(c)
    }
}

