//
//  Token.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 8/31/18.
//

import Foundation

// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html

public enum Punctuation: String,  AutoEquatable {
    case leftParen = "\u{0028}"
    case rightParen = "\u{0029}"
    case leftSquareBracket = "\u{005B}"
    case rightSquareBracket = "\u{005D}"
    case leftCurlyBracket = "\u{007B}"
    case rightCurlyBracket = "\u{007D}"
    case dot = "\u{002E}"
    case comma = "\u{002C}"
    case colon = "\u{003A}"
    case semicolon = "\u{003B}"
}

public enum TokenType {
    case whitespace(Whitespace)
    case punctuation(Punctuation)
    case keyword(Keyword)
    case slash // FIXME
    
    // Operator
    
    // Identifier
    
    // Literal
    
    // Keyword
    
    case eof
}

extension TokenType: AutoEquatable {}

public struct Token {
    let type: TokenType
    let line: Int
    
    public init(type: TokenType, line: Int) {
        self.type = type
        self.line = line
    }
}

extension Token: Equatable {
    public static func ==(lhs: Token, rhs: Token) -> Bool {
        return lhs.type == rhs.type && lhs.line == rhs.line
    }
}

extension Token: CustomStringConvertible {
    public var description: String {
        return "\(type) - line: \(line)"
    }
}

