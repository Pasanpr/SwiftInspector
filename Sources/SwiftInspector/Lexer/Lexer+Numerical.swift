//
//  Lexer+Numerical.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 2/11/19.
//

import Foundation

extension Lexer {
    func isDigit(_ c: UnicodeScalar) -> Bool {
        let integerNumberCharacterSet = CharacterSet(charactersIn: Unicode.Scalar("0")...Unicode.Scalar("9"))
        return integerNumberCharacterSet.contains(c)
    }
    
    func numericalLiteral() -> Token? {
        while isDigit(peek()) { let _ = advance() }
        
        // Look for fractional part
        if peek() == "." && isDigit(peekNext()) {
            // Consume the decimal
            let _ = advance()
            
            while isDigit(peek()) { let _ = advance() }
            
            let lexeme = substringInSource(from: start, to: current)
            guard let floatingPointValue = Double(lexeme) else {
                return nil
            }
            
            return Token(type: .literal(.floatingPoint(floatingPointValue)), line: line)
        } else {
            let lexeme = substringInSource(from: start, to: current)
            guard let integerValue = Int(lexeme) else {
                return nil
            }
            
            return Token(type: .literal(.integer(integerValue)), line: line)
        }
    }
}
