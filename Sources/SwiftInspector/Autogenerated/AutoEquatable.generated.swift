// Generated using Sourcery 0.14.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs

// MARK: - AutoEquatable for Enums
// MARK: - Declaration AutoEquatable
extension Declaration: Equatable {}
public func == (lhs: Declaration, rhs: Declaration) -> Bool {
    switch (lhs, rhs) {
    case (.`associatedtype`, .`associatedtype`):
        return true
    case (.`class`, .`class`):
        return true
    case (.`deinit`, .`deinit`):
        return true
    case (.`enum`, .`enum`):
        return true
    case (.`extension`, .`extension`):
        return true
    case (.`fileprivate`, .`fileprivate`):
        return true
    case (.`func`, .`func`):
        return true
    case (.`import`, .`import`):
        return true
    case (.`init`, .`init`):
        return true
    case (.`inout`, .`inout`):
        return true
    case (.`internal`, .`internal`):
        return true
    case (.`let`, .`let`):
        return true
    case (.`open`, .`open`):
        return true
    case (.`operator`, .`operator`):
        return true
    case (.`private`, .`private`):
        return true
    case (.`protocol`, .`protocol`):
        return true
    case (.`public`, .`public`):
        return true
    case (.`static`, .`static`):
        return true
    case (.`struct`, .`struct`):
        return true
    case (.`subscript`, .`subscript`):
        return true
    case (.`typealias`, .`typealias`):
        return true
    case (.`var`, .`var`):
        return true
    default: return false
    }
}
// MARK: - Expression AutoEquatable
extension Expression: Equatable {}
public func == (lhs: Expression, rhs: Expression) -> Bool {
    switch (lhs, rhs) {
    case (.`break`, .`break`):
        return true
    case (.`case`, .`case`):
        return true
    case (.`continue`, .`continue`):
        return true
    case (.`default`, .`default`):
        return true
    case (.`defer`, .`defer`):
        return true
    case (.`do`, .`do`):
        return true
    case (.`else`, .`else`):
        return true
    case (.`fallthrough`, .`fallthrough`):
        return true
    case (.`for`, .`for`):
        return true
    case (.`guard`, .`guard`):
        return true
    case (.`if`, .`if`):
        return true
    case (.`in`, .`in`):
        return true
    case (.`repeat`, .`repeat`):
        return true
    case (.`return`, .`return`):
        return true
    case (.`switch`, .`switch`):
        return true
    case (.`where`, .`where`):
        return true
    case (.`while`, .`while`):
        return true
    default: return false
    }
}
// MARK: - Keyword AutoEquatable
extension Keyword: Equatable {}
public func == (lhs: Keyword, rhs: Keyword) -> Bool {
    switch (lhs, rhs) {
    case (.declaration(let lhs), .declaration(let rhs)):
        return lhs == rhs
    case (.expression(let lhs), .expression(let rhs)):
        return lhs == rhs
    default: return false
    }
}
// MARK: - LineBreak AutoEquatable
extension LineBreak: Equatable {}
public func == (lhs: LineBreak, rhs: LineBreak) -> Bool {
    switch (lhs, rhs) {
    case (.carriageReturn, .carriageReturn):
        return true
    case (.newline, .newline):
        return true
    default: return false
    }
}
// MARK: - Punctuation AutoEquatable
extension Punctuation: Equatable {}
public func == (lhs: Punctuation, rhs: Punctuation) -> Bool {
    switch (lhs, rhs) {
    case (.leftParen, .leftParen):
        return true
    case (.rightParen, .rightParen):
        return true
    case (.leftSquareBracket, .leftSquareBracket):
        return true
    case (.rightSquareBracket, .rightSquareBracket):
        return true
    case (.leftCurlyBracket, .leftCurlyBracket):
        return true
    case (.rightCurlyBracket, .rightCurlyBracket):
        return true
    case (.dot, .dot):
        return true
    case (.comma, .comma):
        return true
    case (.colon, .colon):
        return true
    case (.semicolon, .semicolon):
        return true
    default: return false
    }
}
// MARK: - TokenType AutoEquatable
extension TokenType: Equatable {}
public func == (lhs: TokenType, rhs: TokenType) -> Bool {
    switch (lhs, rhs) {
    case (.whitespace(let lhs), .whitespace(let rhs)):
        return lhs == rhs
    case (.punctuation(let lhs), .punctuation(let rhs)):
        return lhs == rhs
    case (.keyword(let lhs), .keyword(let rhs)):
        return lhs == rhs
    case (.slash, .slash):
        return true
    case (.eof, .eof):
        return true
    default: return false
    }
}
// MARK: - Whitespace AutoEquatable
extension Whitespace: Equatable {}
public func == (lhs: Whitespace, rhs: Whitespace) -> Bool {
    switch (lhs, rhs) {
    case (.whitespaceItem(let lhs), .whitespaceItem(let rhs)):
        return lhs == rhs
    case (.lineBreak(let lhs), .lineBreak(let rhs)):
        return lhs == rhs
    case (.comment(let lhs), .comment(let rhs)):
        return lhs == rhs
    case (.multiLineComment(let lhs), .multiLineComment(let rhs)):
        return lhs == rhs
    default: return false
    }
}
// MARK: - WhitespaceItem AutoEquatable
extension WhitespaceItem: Equatable {}
public func == (lhs: WhitespaceItem, rhs: WhitespaceItem) -> Bool {
    switch (lhs, rhs) {
    case (.null, .null):
        return true
    case (.horizontalTab, .horizontalTab):
        return true
    case (.verticalTab, .verticalTab):
        return true
    case (.formFeed, .formFeed):
        return true
    case (.space, .space):
        return true
    default: return false
    }
}
