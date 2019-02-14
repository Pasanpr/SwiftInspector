//
//  Primary.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

/*
 GRAMMAR OF A PRIMARY EXPRESSION
 
 primary-expression → identifier generic-argument-clause opt
 primary-expression → literal-expression
 primary-expression → self-expression
 primary-expression → superclass-expression
 primary-expression → closure-expression
 primary-expression → parenthesized-expression
 primary-expression → tuple-expression
 primary-expression → implicit-member-expression
 primary-expression → wildcard-expression
 primary-expression → key-path-expression
 primary-expression → selector-expression
 primary-expression → key-path-string-expression
 */

public enum PrimaryExpression {
    /*
     GRAMMAR OF A LITERAL EXPRESSION
     
     literal-expression → literal
     literal-expression → array-literal | dictionary-literal | playground-literal
     literal-expression → #file | #line | #column | #function | #dsohandle
     array-literal → [ array-literal-items opt ]
     array-literal-items → array-literal-item ,opt | array-literal-item , array-literal-items
     array-literal-item → expression
     dictionary-literal → [ dictionary-literal-items ] | [ : ]
     dictionary-literal-items → dictionary-literal-item ,opt | dictionary-literal-item , dictionary-literal-items
     dictionary-literal-item → expression : expression
     playground-literal → #colorLiteral ( red : expression , green : expression , blue : expression , alpha : expression )
     playground-literal → #fileLiteral ( resourceName : expression )
     playground-literal → #imageLiteral ( resourceName : expression )
     */
    case identifier(String, genericArgs: String?)
    case literal(String)
    case `self`
    case superclass
    case closure
    case parenthesized
    case tuple
    case implicitMember
    case wildcard
    case keyPath
    case selector
    case keyPathString
}

extension PrimaryExpression: AutoEquatable {}

extension PrimaryExpression: CustomStringConvertible {
    public var description: String {
        switch self {
        case .literal(let name): return name
        case .identifier(let name, let genericArgs): return name
        default: fatalError()
        }
    }
}
