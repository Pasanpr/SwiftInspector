//
//  TokenType.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

public enum TokenType {
    case whitespace(Whitespace)
    case punctuation(Punctuation)
    case keyword(Keyword)
    case `operator`(Operator)
    case literal(Literal)
    case identifier(String)
    case eof
    
    public enum Whitespace {
        public enum LineBreak: String, AutoEquatable {
            case carriageReturn = "\u{000D}"
            case newline = "\u{000A}"
        }
        
        public enum WhitespaceItem: String, AutoEquatable {
            case null = "\u{0000}"
            case horizontalTab = "\u{0009}"
            case verticalTab = "\u{000B}"
            case formFeed = "\u{000C}"
            case space = "\u{0020}"
        }
        
        case whitespaceItem(WhitespaceItem)
        case lineBreak(LineBreak)
        case comment(String)
        case multiLineComment(String)
    }
}

extension TokenType: AutoEquatable {}

extension TokenType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .whitespace(let whitespace): return whitespace.description
        case .punctuation(_): return "implement"
        case .keyword(_): return "implement"
        case .operator(let `operator`): return `operator`.description
        case .literal(let literal): return literal.description
        case .identifier(let name): return name
        case .eof: return "EOF"
        }
    }
}
