//
//  SwiftParserTests.swift
//  SwiftInspectorTests
//
//  Created by Pasan Premaratne on 11/12/18.
//

@testable import SwiftInspector
import XCTest

fileprivate extension Program {
    static var additionExprProgram: Program {
        let op = Token(type: .operator(.addition), line: 1)
        let lhs = Expression.prefix(operator: nil, rhs: .primary(.literal("1")))
        let rhs = Expression.prefix(operator: nil, rhs: .primary(.literal("2")))
        let expr = Expression.binary(operator: op, lhs: lhs, rhs: rhs)
        
        let statements = [
            Statement.expression(expr)
        ]
        
        return Program(statements: statements)
    }
}

class SwiftParserTests: XCTestCase {
    
    let swiftParser = SwiftParser()

    func testAdditionExpression() {
        let source = "1 + 2"
        
        
    }
}
