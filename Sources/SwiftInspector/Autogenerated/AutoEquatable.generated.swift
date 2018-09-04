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
// MARK: - TokenType AutoEquatable
extension TokenType: Equatable {}
public func == (lhs: TokenType, rhs: TokenType) -> Bool {
    switch (lhs, rhs) {
    case (.newline, .newline):
        return true
    case (.leftParen, .leftParen):
        return true
    case (.rightParen, .rightParen):
        return true
    case (.leftBrace, .leftBrace):
        return true
    case (.rightBrace, .rightBrace):
        return true
    case (.dot, .dot):
        return true
    case (.comma, .comma):
        return true
    case (.colon, .colon):
        return true
    case (.semicolon, .semicolon):
        return true
    case (.whitespace(let lhs), .whitespace(let rhs)):
        return lhs == rhs
    case (.comment(let lhs), .comment(let rhs)):
        return lhs == rhs
    case (.slash, .slash):
        return true
    case (.eof, .eof):
        return true
    default: return false
    }
}
