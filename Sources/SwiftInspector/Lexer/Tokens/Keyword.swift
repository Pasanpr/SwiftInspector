//
//  Keyword.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/6/18.
//

public enum Keyword: AutoEquatable {
    public enum Declaration: String, AutoEquatable, CaseIterable {
        case `associatedtype`
        case `class`
        case `deinit`
        case `enum`
        case `extension`
        case `fileprivate`
        case `func`
        case `import`
        case `init`
        case `inout`
        case `internal`
        case `let`
        case `open`
        case `operator`
        case `private`
        case `protocol`
        case `public`
        case `static`
        case `struct`
        case `subscript`
        case `typealias`
        case `var`
    }
    
    public enum Expression: String, CaseIterable, AutoEquatable {
        case `break`
        case `case`
        case `continue`
        case `default`
        case `defer`
        case `do`
        case `else`
        case `fallthrough`
        case `for`
        case `guard`
        case `if`
        case `in`
        case `repeat`
        case `return`
        case `switch`
        case `where`
        case `while`
    }
    
    public enum Statement: String, AutoEquatable {
        case `as`
        case `Any`
        case `catch`
        case `is`
        case `nil`
        case `rethrows`
        case `super`
        case `self`
        case `Self`
        case `throw`
        case `throws`
        case `try`
    }
    
    public enum Pound: String, AutoEquatable {
        case available = "#available"
        case colorLiteral = "#colorLiteral"
        case column = "#column"
        case `else` = "#else"
        case elseif = "#elseif"
        case endif = "#endif"
        case error = "#error"
        case file = "#file"
        case fileLiteral = "#fileLiteral"
        case function = "#function"
        case `if` = "#if"
        case imageLiteral = "#imageLiteral"
        case line = "#line"
        case selector = "#selector"
        case sourceLocation = "#sourceLocation"
        case warning = "#warning"
    }
    
    case declaration(Declaration)
    case expression(Expression)
    case statement(Statement)
    case pound(Pound)
    case pattern
}
