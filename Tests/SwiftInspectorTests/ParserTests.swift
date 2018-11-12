//
//  ParserTests.swift
//  SwiftInspectorTests
//
//  Created by Pasan Premaratne on 9/27/18.
//

@testable import SwiftInspector
import XCTest

class ParserTests: XCTestCase {

    func testParser() {
        let tokens = [
            Token(type: .literal(.integer(1)), line: 1),
            Token(type: .operator(.addition), line: 1),
            Token(type: .literal(.integer(2)), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let parser = Parser(tokens: tokens)
        let program = try! parser.parse()
    }

}
