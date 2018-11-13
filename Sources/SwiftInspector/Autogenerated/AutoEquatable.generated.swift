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
// MARK: - Program AutoEquatable
extension Program: Equatable {}
public func == (lhs: Program, rhs: Program) -> Bool {
    guard lhs.statements == rhs.statements else { return false }
    return true
}

// MARK: - AutoEquatable for Enums
// MARK: - BinaryExpression AutoEquatable
extension BinaryExpression: Equatable {}
public func == (lhs: BinaryExpression, rhs: BinaryExpression) -> Bool {
    switch (lhs, rhs) {
    case (.binary(let lhs), .binary(let rhs)):
        if lhs.operator != rhs.operator { return false }
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case (.assignment(let lhs), .assignment(let rhs)):
        if lhs.try != rhs.try { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case (.conditional, .conditional):
        return true
    case (.typeCasting(let lhs), .typeCasting(let rhs)):
        if lhs.operator != rhs.operator { return false }
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    default: return false
    }
}
// MARK: - Declaration AutoEquatable
extension Declaration: Equatable {}
public func == (lhs: Declaration, rhs: Declaration) -> Bool {
    switch (lhs, rhs) {
    case (.variable(let lhs), .variable(let rhs)):
        if lhs.identifier != rhs.identifier { return false }
        if lhs.type != rhs.type { return false }
        if lhs.expression != rhs.expression { return false }
        return true
    case (.constant(let lhs), .constant(let rhs)):
        if lhs.name != rhs.name { return false }
        if lhs.type != rhs.type { return false }
        if lhs.expression != rhs.expression { return false }
        return true
    default: return false
    }
}
// MARK: - Expression AutoEquatable
extension Expression: Equatable {}
public func == (lhs: Expression, rhs: Expression) -> Bool {
    switch (lhs, rhs) {
    case (.prefix(let lhs), .prefix(let rhs)):
        if lhs.operator != rhs.operator { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case (.binary(let lhs), .binary(let rhs)):
        if lhs.operator != rhs.operator { return false }
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case (.primary(let lhs), .primary(let rhs)):
        return lhs == rhs
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
    case (.statement(let lhs), .statement(let rhs)):
        return lhs == rhs
    case (.pound(let lhs), .pound(let rhs)):
        return lhs == rhs
    case (.pattern, .pattern):
        return true
    default: return false
    }
}
// MARK: - Keyword.Declaration AutoEquatable
extension Keyword.Declaration: Equatable {}
public func == (lhs: Keyword.Declaration, rhs: Keyword.Declaration) -> Bool {
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
// MARK: - Keyword.Expression AutoEquatable
extension Keyword.Expression: Equatable {}
public func == (lhs: Keyword.Expression, rhs: Keyword.Expression) -> Bool {
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
// MARK: - Keyword.Pound AutoEquatable
extension Keyword.Pound: Equatable {}
public func == (lhs: Keyword.Pound, rhs: Keyword.Pound) -> Bool {
    switch (lhs, rhs) {
    case (.available, .available):
        return true
    case (.colorLiteral, .colorLiteral):
        return true
    case (.column, .column):
        return true
    case (.`else`, .`else`):
        return true
    case (.elseif, .elseif):
        return true
    case (.endif, .endif):
        return true
    case (.error, .error):
        return true
    case (.file, .file):
        return true
    case (.fileLiteral, .fileLiteral):
        return true
    case (.function, .function):
        return true
    case (.`if`, .`if`):
        return true
    case (.imageLiteral, .imageLiteral):
        return true
    case (.line, .line):
        return true
    case (.selector, .selector):
        return true
    case (.sourceLocation, .sourceLocation):
        return true
    case (.warning, .warning):
        return true
    default: return false
    }
}
// MARK: - Keyword.Statement AutoEquatable
extension Keyword.Statement: Equatable {}
public func == (lhs: Keyword.Statement, rhs: Keyword.Statement) -> Bool {
    switch (lhs, rhs) {
    case (.`as`, .`as`):
        return true
    case (.`Any`, .`Any`):
        return true
    case (.`catch`, .`catch`):
        return true
    case (.`is`, .`is`):
        return true
    case (.`nil`, .`nil`):
        return true
    case (.`rethrows`, .`rethrows`):
        return true
    case (.`super`, .`super`):
        return true
    case (.`self`, .`self`):
        return true
    case (.`Self`, .`Self`):
        return true
    case (.`throw`, .`throw`):
        return true
    case (.`throws`, .`throws`):
        return true
    case (.`try`, .`try`):
        return true
    default: return false
    }
}
// MARK: - Literal AutoEquatable
extension Literal: Equatable {}
public func == (lhs: Literal, rhs: Literal) -> Bool {
    switch (lhs, rhs) {
    case (.integer(let lhs), .integer(let rhs)):
        return lhs == rhs
    case (.floatingPoint(let lhs), .floatingPoint(let rhs)):
        return lhs == rhs
    case (.string(let lhs), .string(let rhs)):
        return lhs == rhs
    case (.interpolatedString(let lhs), .interpolatedString(let rhs)):
        return lhs == rhs
    case (.boolean(let lhs), .boolean(let rhs)):
        return lhs == rhs
    default: return false
    }
}
// MARK: - Operator AutoEquatable
extension Operator: Equatable {}
public func == (lhs: Operator, rhs: Operator) -> Bool {
    switch (lhs, rhs) {
    case (.assignment, .assignment):
        return true
    case (.addition, .addition):
        return true
    case (.subtraction, .subtraction):
        return true
    case (.multiplication, .multiplication):
        return true
    case (.division, .division):
        return true
    case (.remainder, .remainder):
        return true
    case (.additionAssignment, .additionAssignment):
        return true
    case (.subtractionAssignment, .subtractionAssignment):
        return true
    case (.remainderAssignment, .remainderAssignment):
        return true
    case (.divisionAssignment, .divisionAssignment):
        return true
    case (.multiplicationAssignment, .multiplicationAssignment):
        return true
    case (.prefixMinus, .prefixMinus):
        return true
    case (.prefixPlus, .prefixPlus):
        return true
    case (.equalTo, .equalTo):
        return true
    case (.notEqualTo, .notEqualTo):
        return true
    case (.greaterThan, .greaterThan):
        return true
    case (.lessThan, .lessThan):
        return true
    case (.greaterThanOrEqual, .greaterThanOrEqual):
        return true
    case (.lessThanOrEqual, .lessThanOrEqual):
        return true
    case (.identity, .identity):
        return true
    case (.identityNot, .identityNot):
        return true
    case (.nilCoalescing, .nilCoalescing):
        return true
    case (.ternaryConditional, .ternaryConditional):
        return true
    case (.closedRange, .closedRange):
        return true
    case (.halfOpenRange, .halfOpenRange):
        return true
    case (.oneSidedRange, .oneSidedRange):
        return true
    case (.logicalNot, .logicalNot):
        return true
    case (.logicalAnd, .logicalAnd):
        return true
    case (.logicalOr, .logicalOr):
        return true
    case (.returnType, .returnType):
        return true
    case (.optional, .optional):
        return true
    case (.forcedOptional, .forcedOptional):
        return true
    default: return false
    }
}
// MARK: - PostfixExpression AutoEquatable
extension PostfixExpression: Equatable {}
public func == (lhs: PostfixExpression, rhs: PostfixExpression) -> Bool {
    switch (lhs, rhs) {
    case (.primary(let lhs), .primary(let rhs)):
        return lhs == rhs
    case (.postfix(let lhs), .postfix(let rhs)):
        if lhs.expression != rhs.expression { return false }
        if lhs.operator != rhs.operator { return false }
        return true
    case (.functionCall, .functionCall):
        return true
    case (.initializer, .initializer):
        return true
    case (.explicitMember, .explicitMember):
        return true
    case (.postfixSelf, .postfixSelf):
        return true
    case (.`subscript`, .`subscript`):
        return true
    case (.forcedValue, .forcedValue):
        return true
    case (.optionalChaining, .optionalChaining):
        return true
    default: return false
    }
}
// MARK: - PrefixExpression AutoEquatable
extension PrefixExpression: Equatable {}
public func == (lhs: PrefixExpression, rhs: PrefixExpression) -> Bool {
    switch (lhs, rhs) {
    case (.`inout`(let lhs), .`inout`(let rhs)):
        return lhs == rhs
    }
}
// MARK: - PrimaryExpression AutoEquatable
extension PrimaryExpression: Equatable {}
public func == (lhs: PrimaryExpression, rhs: PrimaryExpression) -> Bool {
    switch (lhs, rhs) {
    case (.identifier(let lhs), .identifier(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.genericArgs != rhs.genericArgs { return false }
        return true
    case (.literal(let lhs), .literal(let rhs)):
        return lhs == rhs
    case (.`self`, .`self`):
        return true
    case (.superclass, .superclass):
        return true
    case (.closure, .closure):
        return true
    case (.parenthesized, .parenthesized):
        return true
    case (.tuple, .tuple):
        return true
    case (.implicitMember, .implicitMember):
        return true
    case (.wildcard, .wildcard):
        return true
    case (.keyPath, .keyPath):
        return true
    case (.selector, .selector):
        return true
    case (.keyPathString, .keyPathString):
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
    case (.leftCurlyBracket, .leftCurlyBracket):
        return true
    case (.rightCurlyBracket, .rightCurlyBracket):
        return true
    case (.leftSquareBracket, .leftSquareBracket):
        return true
    case (.rightSquareBracket, .rightSquareBracket):
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
// MARK: - Statement AutoEquatable
extension Statement: Equatable {}
public func == (lhs: Statement, rhs: Statement) -> Bool {
    switch (lhs, rhs) {
    case (.expression(let lhs), .expression(let rhs)):
        return lhs == rhs
    case (.declaration(let lhs), .declaration(let rhs)):
        return lhs == rhs
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
    case (.`operator`(let lhs), .`operator`(let rhs)):
        return lhs == rhs
    case (.literal(let lhs), .literal(let rhs)):
        return lhs == rhs
    case (.identifier(let lhs), .identifier(let rhs)):
        return lhs == rhs
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
// MARK: - Whitespace.LineBreak AutoEquatable
extension Whitespace.LineBreak: Equatable {}
public func == (lhs: Whitespace.LineBreak, rhs: Whitespace.LineBreak) -> Bool {
    switch (lhs, rhs) {
    case (.carriageReturn, .carriageReturn):
        return true
    case (.newline, .newline):
        return true
    default: return false
    }
}
// MARK: - Whitespace.WhitespaceItem AutoEquatable
extension Whitespace.WhitespaceItem: Equatable {}
public func == (lhs: Whitespace.WhitespaceItem, rhs: Whitespace.WhitespaceItem) -> Bool {
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
