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
    private var source: String
    private var tokens: Array<Token>
    private var start = 0
    public var current = 0
    private var line = 1
    
    private var isAtEnd: Bool {
        return current >= source.count
    }
    
    convenience init() {
        self.init(source: "")
    }
    
    init(source: String) {
        self.source = source
        self.tokens = []
    }
    
    public func scan(source: String) throws -> [Token] {
        self.source = source
        return try scan()
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
        case ".":
            if peek() == "." {
                while peek() == "." && !isAtEnd {
                    let _ = advance()
                }
                
                if match(expected: "<") {
                    return Token(type: .operator(.halfOpenRange), line: line)
                } else {
                    return Token(type: .operator(.closedRange), line: line)
                }
            } else {
                return Token(type: .punctuation(.dot), line: line)
            }
        case ",": return Token(type: .punctuation(.comma), line: line)
        case ":": return Token(type: .punctuation(.colon), line: line)
        case ";": return Token(type: .punctuation(.semicolon), line: line)
        case "/":
            if match(expected: "=") {
                return Token(type: .operator(.divisionAssignment), line: line)
            } else if match(expected: "/") {
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
                return Token(type: .operator(.division), line: line)
            }
        case " ":
            while (peek() == " " && !isAtEnd) {
                let _ = advance()
            }
            
            return Token(type: .whitespace(.whitespaceItem(.space)), line: line)
        case "=":
            while (peek() == "=" && !isAtEnd) {
                let _ = advance()
            }
            
            let substring = substringInSource(from: start, to: current)
            
            switch substring {
            case "=": return Token(type: .operator(.assignment), line: line)
            case "==": return Token(type: .operator(.equalTo), line: line)
            case "===": return Token(type: .operator(.identity), line: line)
            default:
                throw LexerError.invalidToken
            }
        case "+":
            if match(expected: "=") {
                return Token(type: .operator(.additionAssignment), line: line)
            } else {
                return Token(type: .operator(.addition), line: line)
            }
        case "-":
            if match(expected: "=") {
                return Token(type: .operator(.subtractionAssignment), line: line)
            } else {
                return Token(type: .operator(.subtraction), line: line)
            }
        case "*":
            if match(expected: "=") {
                return Token(type: .operator(.multiplicationAssignment), line: line)
            } else {
                return Token(type: .operator(.multiplication), line: line)
            }
        case "%":
            if match(expected: "=") {
                return Token(type: .operator(.remainderAssignment), line: line)
            } else {
                return Token(type: .operator(.remainder), line: line)
            }
        case "!":
            if match(expected: "=") {
                while (peek() == "=" && !isAtEnd) {
                    let _ = advance()
                }
                
                let substring = substringInSource(from: start, to: current)
                
                switch substring {
                case "!=": return Token(type: .operator(.notEqualTo), line: line)
                case "!==": return Token(type: .operator(.identityNot), line: line)
                default: throw LexerError.invalidToken
                }
            } else if isIdentifierHead(peek()) {
                return Token(type: .operator(.logicalNot), line: line)
            } else {
                return Token(type: .operator(.forcedOptional), line: line)
            }
        case "<":
            if match(expected: "=") {
                return Token(type: .operator(.lessThanOrEqual), line: line)
            } else {
                return Token(type: .operator(.lessThan), line: line)
            }
        case ">":
            if match(expected: "=") {
                return Token(type: .operator(.greaterThanOrEqual), line: line)
            } else {
                return Token(type: .operator(.greaterThan), line: line)
            }
        case "?":
            if match(expected: "?") {
                return Token(type: .operator(.nilCoalescing), line: line)
            } else {
                return Token(type: .operator(.optional), line: line)
            }
        case "&":
            if match(expected: "&") {
                return Token(type: .operator(.logicalAnd), line: line)
            } else {
                fatalError()
            }
        case "|":
            if match(expected: "|") {
                return Token(type: .operator(.logicalOr), line: line)
            } else {
                fatalError()
            }
        case "\"":
            return stringLiteral()
        case "\\":
            // Key Paths
            fatalError()
        case "#":
            while (!isAtEnd && !isWhitespace(peek())) {
                let _ = advance()
            }
            
            let lexeme = substringInSource(from: start, to: current)
            
            if let pound = Keyword.Pound(rawValue: lexeme) {
                return Token(type: .keyword(.pound(pound)), line: line)
            } else {
                fatalError()
            }
        case "`":
            while (!isAtEnd && peek() != "`") {
                let _ = advance()
            }
            
            let lexeme = substringInSource(from: start + 1, to: current)
            
            // Consume closing backtick
            let _ = advance()
            return Token(type: .identifier(lexeme), line: line)
        default:
            if isIdentifierHead(character) {
                while (!isAtEnd && !isReservedPunctuation(peek()) && !isWhitespace(peek())) {
                    let _ = advance()
                }
                
                let lexeme = substringInSource(from: start, to: current)
                
                if let declaration = Keyword.Declaration(rawValue: lexeme) {
                    return Token(type: .keyword(.declaration(declaration)), line: line)
                } else if let expression = Keyword.Expression(rawValue: lexeme) {
                    return Token(type: .keyword(.expression(expression)), line: line)
                } else if let statement = Keyword.Statement(rawValue: lexeme) {
                    return Token(type: .keyword(.statement(statement)), line: line)
                } else if let booleanLiteralToken = booleanLiteral(withLexeme: lexeme) {
                    return booleanLiteralToken
                } else {
                    let firstIndex = lexeme.index(after: lexeme.startIndex)
                    let tail = String(lexeme[firstIndex...])
                    
                    for scalar in tail.unicodeScalars {
                        if !isIdentifierTail(scalar) {
                            fatalError()
                        }
                    }
                    
                    return Token(type: .identifier(lexeme), line: line)
                }
            } else if isDigit(character) {
                if let numericalLiteralToken = numericalLiteral() {
                    return numericalLiteralToken
                } else {
                    throw LexerError.invalidToken
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
        return peek(aheadBy: current)
    }
    
    private func peekNext() -> UnicodeScalar {
        return peek(aheadBy: current + 1)
    }
    
    private func peek(aheadBy i: Int) -> UnicodeScalar {
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
    
    public func isIdentifierHead(_ c: UnicodeScalar) -> Bool {
        // https://github.com/nicklockwood/SwiftFormat/blob/1873197ca6b64b1d72585b69df433d40d600f3ce/Sources/Tokenizer.swift#L734
        switch c.value {
        case 0x41...0x5A, // A-Z
        0x61 ... 0x7A, // a-z
        0x5F, 0x24, // _ and $
        0x00A8, 0x00AA, 0x00AD, 0x00AF,
        0x00B2 ... 0x00B5,
        0x00B7 ... 0x00BA,
        0x00BC ... 0x00BE,
        0x00C0 ... 0x00D6,
        0x00D8 ... 0x00F6,
        0x00F8 ... 0x00FF,
        0x0100 ... 0x02FF,
        0x0370 ... 0x167F,
        0x1681 ... 0x180D,
        0x180F ... 0x1DBF,
        0x1E00 ... 0x1FFF,
        0x200B ... 0x200D,
        0x202A ... 0x202E,
        0x203F ... 0x2040,
        0x2054,
        0x2060 ... 0x206F,
        0x2070 ... 0x20CF,
        0x2100 ... 0x218F,
        0x2460 ... 0x24FF,
        0x2776 ... 0x2793,
        0x2C00 ... 0x2DFF,
        0x2E80 ... 0x2FFF,
        0x3004 ... 0x3007,
        0x3021 ... 0x302F,
        0x3031 ... 0x303F,
        0x3040 ... 0xD7FF,
        0xF900 ... 0xFD3D,
        0xFD40 ... 0xFDCF,
        0xFDF0 ... 0xFE1F,
        0xFE30 ... 0xFE44,
        0xFE47 ... 0xFFFD,
        0x10000 ... 0x1FFFD,
        0x20000 ... 0x2FFFD,
        0x30000 ... 0x3FFFD,
        0x40000 ... 0x4FFFD,
        0x50000 ... 0x5FFFD,
        0x60000 ... 0x6FFFD,
        0x70000 ... 0x7FFFD,
        0x80000 ... 0x8FFFD,
        0x90000 ... 0x9FFFD,
        0xA0000 ... 0xAFFFD,
        0xB0000 ... 0xBFFFD,
        0xC0000 ... 0xCFFFD,
        0xD0000 ... 0xDFFFD,
        0xE0000 ... 0xEFFFD:
            return true
        default:
            return false
        }
    }
    
    func isIdentifierTail(_ c: UnicodeScalar) -> Bool {
        switch c.value {
        case 0x30 ... 0x39, // 0-9
        0x0300 ... 0x036F,
        0x1DC0 ... 0x1DFF,
        0x20D0 ... 0x20FF,
        0xFE20 ... 0xFE2F:
            return true
        default:
            return isIdentifierHead(c)
        }
    }
    
    public func isWhitespace(_ c: UnicodeScalar) -> Bool {
        let set = CharacterSet.whitespacesAndNewlines
        return set.contains(c)
    }
    
    public func isReservedPunctuation(_ c: UnicodeScalar) -> Bool {
        var set = CharacterSet()
        set.insert(charactersIn: "!?")
        return set.contains(c)
    }
    
    public func isDigit(_ c: UnicodeScalar) -> Bool {
        let integerNumberCharacterSet = CharacterSet(charactersIn: Unicode.Scalar("0")...Unicode.Scalar("9"))
        return integerNumberCharacterSet.contains(c)
    }
    
    public func numericalLiteral() -> Token? {
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
    
    public func stringLiteral() -> Token {
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
    
    public func booleanLiteral(withLexeme lexeme: String) -> Token? {
        switch lexeme {
        case "true": return Token(type: .literal(.boolean(true)), line: line)
        case "false": return Token(type: .literal(.boolean(false)), line: line)
        default: return nil
        }
    }
}

