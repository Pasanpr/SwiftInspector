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
