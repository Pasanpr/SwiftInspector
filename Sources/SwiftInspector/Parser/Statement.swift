//
//  Statement.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

public enum Statement {
    case expression(Expression)
    case declaration(Declaration)
}

extension Statement: AutoEquatable {}



