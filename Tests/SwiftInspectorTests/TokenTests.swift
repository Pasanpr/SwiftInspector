//
//  TokenTests.swift
//  SwiftInspectorTests
//
//  Created by Pasan Premaratne on 9/1/18.
//

import XCTest
@testable import SwiftInspector

class TokenTests: XCTestCase {
    // MARK: - Single character tokens
    
    func testEmptyString() {
        let input = ""
        let output: [Token] = [
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testSingleSpace() {
        let input = " "
        let output: [Token] = [
            Token(type: .space(" "), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testMultipleSpace() {
        let input = "  "
        let output: [Token] = [
            Token(type: .space("  "), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testSingleParen() {
        let input = "("
        let output: [Token] = [
            Token(type: .leftParen, line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testMultipleParens() {
        let input = "()"
        let output: [Token] = [
            Token(type: .leftParen, line: 1),
            Token(type: .rightParen, line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testParensWithMultipleSpaces() {
        let input = "(  )"
        let output: [Token] = [
            Token(type: .leftParen, line: 1),
            Token(type: .space("  "), line: 1),
            Token(type: .rightParen, line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
}
