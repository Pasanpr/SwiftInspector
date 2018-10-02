//
//  LexerTests.swift
//  SwiftInspectorTests
//
//  Created by Pasan Premaratne on 9/1/18.
//

import XCTest
@testable import SwiftInspector

class LexerTests: XCTestCase {

    let source = "var abc = 1"
    
    lazy var lexer: Lexer = {
        return Lexer(source: source)
    }()
    
    func testCharacterAtIndexOffsetBy() {
        let first: UnicodeScalar = "v"
        let middle: UnicodeScalar = "b"
        let last: UnicodeScalar = "1"
        
        XCTAssertEqual(lexer.character(in: source, atIndexOffsetBy: 0), first)
        XCTAssertEqual(lexer.character(in: source, atIndexOffsetBy: 5), middle)
        XCTAssertEqual(lexer.character(in: source, atIndexOffsetBy: source.count - 1), last)
    }
    
    func testAdvanceConsumesCharacterAndMovesForward() {
        XCTAssertTrue(lexer.current == 0)
        let c = lexer.advance()
        XCTAssertTrue(c == UnicodeScalar("v"))
        XCTAssertTrue(lexer.current == 1)
    }
    
    func testIsDigit() {
        let numbers: [UnicodeScalar] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
        for number in numbers {
            XCTAssertTrue(lexer.isDigit(number))
        }
        
        let nonNumbers: [UnicodeScalar] = ["a", "!", "<"]
        
        for nonNumber in nonNumbers {
            XCTAssertFalse(lexer.isDigit(nonNumber))
        }
    }
    
    func testIsIdentifier() {
        let input: [UnicodeScalar] = ["1"]
        
        for i in input {
            XCTAssertFalse(lexer.isIdentifierHead(i))
        }
    }
    
    func testIsReservedPunctuation() {
        let input: [UnicodeScalar] = ["?", "!"]
        
        for i in input {
            XCTAssertTrue(lexer.isReservedPunctuation(i))
        }
    }
}
