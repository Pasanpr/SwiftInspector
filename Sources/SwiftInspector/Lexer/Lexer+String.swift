//
//  Lexer+String.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 2/11/19.
//

import Foundation

public extension Lexer {
    func stringLiteral() -> Token {
        var intermediateLiterals = [Literal]()
        // Multi-line string literals
        if peek() == "\"" && peekNext() == "\"" {
            let _ = advance(by: 2)
            var intermediateStart = current
            
            // Check for terminating delimiter
            while peek() != "\"" && peekNext() != "\""  && peek(aheadBy: 3) != "\"" && !isAtEnd {
                if peek() == "\n" { line += 1 }
                let _ = advance()
                
                // Interpolated string encountered. Entire string literal is interpolated
                if peek() == "\\"  && peekNext() == "(" {
                    let initialSubstring = substringInSource(from: intermediateStart, to: current)
                    let stringLiteral = Literal.string(initialSubstring)
                    intermediateLiterals.append(stringLiteral)
                    
                    while (peek() != ")" && !isAtEnd) {
                        let _ = advance()
                    }
                    
                    intermediateStart = current - 1
                    
                    // Consume interpolation end parentheses
                    let _ = advance()
                    var interpolatedSubstring = substringInSource(from: intermediateStart, to: current-1)
                    
                    if interpolatedSubstring.first == "\"" {
                        interpolatedSubstring.removeFirst()
                    }
                    
                    if interpolatedSubstring.last == "\"" {
                        interpolatedSubstring.removeLast()
                    }
                    
                    let interpolatedLiteral = Literal.string(interpolatedSubstring)
                    intermediateLiterals.append(interpolatedLiteral)
                    
                    intermediateStart = current
                }
            }
            
            // Consume the final character & ending quotations
            let _ = advance(by: 4)
            
            let substring = substringInSource(from: intermediateStart, to: current - 3)
            if intermediateLiterals.isEmpty {
                return Token(type: .literal(.string(substring)), line: line)
            } else {
                intermediateLiterals.append(Literal.string(substring))
                return Token(type: .literal(.interpolatedString(intermediateLiterals)), line: line)
            }
        } else {
            var intermediateStart = start + 1
            while peek() != "\"" && !isAtEnd {
                if peek() == "\n" { line += 1 }
                let _ = advance()
                
                if peek() == "\\"  && peekNext() == "(" {
                    let initialSubstring = substringInSource(from: start + 1, to: current)
                    let stringLiteral = Literal.string(initialSubstring)
                    intermediateLiterals.append(stringLiteral)
                    
                    // Set start as the character past the opening delimiter of the interpolated string
                    intermediateStart = current + 2
                    
                    while (peek() != ")" && !isAtEnd) {
                        let _ = advance()
                    }
                    
                    // Consume interpolation end parentheses
                    let _ = advance()
                    var interpolatedSubstring = substringInSource(from: intermediateStart, to: current-1)
                    
                    if interpolatedSubstring.first == "\"" {
                        interpolatedSubstring.removeFirst()
                    }
                    
                    if interpolatedSubstring.last == "\"" {
                        interpolatedSubstring.removeLast()
                    }
                    
                    let interpolatedLiteral = Literal.string(interpolatedSubstring)
                    intermediateLiterals.append(interpolatedLiteral)
                    
                    intermediateStart = current
                }
            }
            
            
            // Consume the closing double quote
            let _ = advance()
            let substring = substringInSource(from: intermediateStart, to: current - 1)
            if intermediateLiterals.isEmpty {
                return Token(type: .literal(.string(substring)), line: line)
            } else {
                intermediateLiterals.append(Literal.string(substring))
                return Token(type: .literal(.interpolatedString(intermediateLiterals)), line: line)
            }
        }
    }
}
