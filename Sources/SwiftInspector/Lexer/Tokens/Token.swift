//
//  Token.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 8/31/18.
//

import Foundation

// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html

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
        return "\(type)"
    }
}

