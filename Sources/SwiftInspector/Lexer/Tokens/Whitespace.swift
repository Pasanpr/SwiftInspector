//
//  Whitespace.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/6/18.
//

import Foundation

public enum Whitespace: AutoEquatable {
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

extension Whitespace: CustomStringConvertible {
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
