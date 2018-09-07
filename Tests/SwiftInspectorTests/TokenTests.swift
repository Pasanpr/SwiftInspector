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
            Token(type: .whitespace(.whitespaceItem(.space)), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testMultipleSpace() {
        let input = "  "
        let output: [Token] = [
            Token(type: .whitespace(.whitespaceItem(.space)), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testSingleParen() {
        let input = "("
        let output: [Token] = [
            Token(type: .punctuation(.leftParen), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testMultipleParens() {
        let input = "()"
        let output: [Token] = [
            Token(type: .punctuation(.leftParen), line: 1),
            Token(type: .punctuation(.rightParen), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testParensWithMultipleSpaces() {
        let input = "(  )"
        let output: [Token] = [
            Token(type: .punctuation(.leftParen), line: 1),
            Token(type: .whitespace(.whitespaceItem(.space)), line: 1),
            Token(type: .punctuation(.rightParen), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testBraces() {
        let input = "{}"
        let output: [Token] = [
            Token(type: .punctuation(.leftCurlyBracket), line: 1),
            Token(type: .punctuation(.rightCurlyBracket), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testPunctuation() {
        let input = ".,:;"
        let output: [Token] = [
            Token(type: .punctuation(.dot), line: 1),
            Token(type: .punctuation(.comma), line: 1),
            Token(type: .punctuation(.colon), line: 1),
            Token(type: .punctuation(.semicolon), line: 1),
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
    
    func testSingleLineComment() {
        let input = "// This is a comment\n"
        
        let output: [Token] = [
            Token(type: .whitespace(.comment("// This is a comment")), line: 1),
            Token(type: .whitespace(.lineBreak(.newline)), line: 1),
            Token(type: .eof, line: 2)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testMultiLineComment() {
        let input = "/* This is a multi line comment.\n\nThat spans a single line.*/"
        
        let output: [Token] = [
            Token(type: .whitespace(.multiLineComment("/* This is a multi line comment.\n\nThat spans a single line.*/")), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testDeclaration() {
        let input = "var"
        
        let output: [Token] = [
            Token(type: .keyword(.declaration(.var)), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
    
    func testExpression() {
        let input = "for"
        
        let output: [Token] = [
            Token(type: .keyword(.expression(.for)), line: 1),
            Token(type: .eof, line: 1)
        ]
        
        let lexer = Lexer(source: input)
        XCTAssertEqual(try! lexer.scan(), output)
    }
}
