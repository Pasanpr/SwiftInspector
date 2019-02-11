//
//  Whitespace.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/6/18.
//

import Foundation

extension TokenType.Whitespace: AutoEquatable {}

extension TokenType.Whitespace: CustomStringConvertible {
    public var description: String {
        switch self {
        case .comment(let comment): return comment
        case .lineBreak(let linebreak):
            switch linebreak {
                case .carriageReturn: return "\\r"
                case .newline: return "\\n"
            }
        case .whitespaceItem(let whitespaceItem):
            switch whitespaceItem {
            case .null: return "null"
            case .horizontalTab: return "\\t"
            case .verticalTab: return "\\t"
            case .formFeed: return "\\f"
            case .space: return " "
            }
        case .multiLineComment(let comment): return comment
        }
    }
}
