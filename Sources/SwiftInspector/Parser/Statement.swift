//
//  Statement.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

indirect public enum Statement {
    case expression(Expression)
    case declaration(Declaration)
    case loopStatement
    case branchStatement
    case labeledStatement
    case controlTransferStatement
    case deferStatement
    case doStatementStatement
    case compilerControlStatement
}

extension Statement: AutoEquatable {}



