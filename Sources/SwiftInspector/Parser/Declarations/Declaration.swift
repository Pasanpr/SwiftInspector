//
//  Declaration.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/29/18.
//

import Foundation

public enum Declaration {
    case variable(identifier: PrimaryExpression, type: String?, expression: Expression)
    case constant(name: String, type: String?, expression: Expression)
}

extension Declaration: AutoEquatable {}
