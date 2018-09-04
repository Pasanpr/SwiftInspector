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
            Token(type: .whitespace(" "), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testMultipleSpace() {
        let input = "  "
        let output: [Token] = [
            Token(type: .whitespace("  "), line: 1),
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
            Token(type: .whitespace("  "), line: 1),
            Token(type: .rightParen, line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testBraces() {
        let input = "{}"
        let output: [Token] = [
            Token(type: .leftBrace, line: 1),
            Token(type: .rightBrace, line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testPunctuation() {
        let input = ".,:;"
        let output: [Token] = [
            Token(type: .dot, line: 1),
            Token(type: .comma, line: 1),
            Token(type: .colon, line: 1),
            Token(type: .semicolon, line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testSlash() {
        let input = "/"
        let output: [Token] = [
            Token(type: .slash, line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testComment() {
        let input = "{} // This is a comment\n"
        let output: [Token] = [
            Token(type: .leftBrace, line: 1),
            Token(type: .rightBrace, line: 1),
            Token(type: .whitespace(" "), line: 1),
            Token(type: .comment("// This is a comment"), line: 1),
            Token(type: .newline, line: 1),
            Token(type: .eof, line: 2)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
}
