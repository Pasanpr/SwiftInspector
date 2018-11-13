//
//  ParserTests.swift
//  SwiftInspectorTests
//
//  Created by Pasan Premaratne on 9/27/18.
//

@testable import SwiftInspector
import XCTest

fileprivate extension Statement {
    static var additionStatement: Statement {
        let op = Token(type: .operator(.addition), line: 1)
        let lhs = Expression.prefix(operator: nil, rhs: .primary(.literal("1")))
        let rhs = Expression.prefix(operator: nil, rhs: .primary(.literal("2")))
        let expr = Expression.binary(operator: op, lhs: lhs, rhs: rhs)
        
        return Statement.expression(expr)
    }
}

fileprivate extension Program {
    static var implicitVariableDeclaration: Program {
        let stmt = Statement.declaration(.variable(identifier: .identifier("foo", genericArgs: nil), type: nil, expression: .prefix(operator: nil, rhs: .primary(.literal("bar")))))
        return Program(statements: [stmt])
    }
}

class ParserTests: XCTestCase {
    func testAdditionExpr() {
        let tokens = [
            Token(type: .literal(.integer(1)), line: 1),
            Token(type: .operator(.addition), line: 1),
            Token(type: .literal(.integer(2)), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let parser = Parser(tokens: tokens)
        let program = try! parser.parse()
        
        XCTAssertTrue(program.statements == [Statement.additionStatement])
    }
    
    func testImplicitVariableDeclaration() {
        // var foo = "bar"
        
        let tokens = [
            Token(type: .keyword(.declaration(.var)), line: 1),
            Token(type: .identifier("foo"), line: 1),
            Token(type: .operator(.assignment), line: 1),
            Token(type: .literal(.string("bar")), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let parser = Parser(tokens: tokens)
        let program = try! parser.parse()
        
        print(program.statements)
        
        XCTAssertTrue(program == Program.implicitVariableDeclaration)
    }
    
    func testExplicitVariableDeclaration() {
        
    }
}
