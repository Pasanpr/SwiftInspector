//
//  Declaration.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/29/18.
//

import Foundation

public enum Declaration {
    case variable(identifier: String, type: Type?, expression: Expression)
    case constant(identifier: String, type: Type?, expression: Expression)
}

extension Declaration: AutoEquatable {}
