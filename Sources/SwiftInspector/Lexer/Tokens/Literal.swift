//
//  Literal.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

public enum Literal: AutoEquatable {
    case integer(Int)
    case floatingPoint(Double)
    case string(String)
    indirect case interpolatedString([Literal])
    case boolean(Bool)
}

extension Literal: CustomStringConvertible {
    public var description: String {
        switch self {
        case .integer(let int): return int.description
        case .floatingPoint(let float): return float.description
        case .string(let string): return string
        case .interpolatedString(let literals):
            return literals.map({ $0.description }).joined()
        case .boolean(let bool): return bool.description
        }
    }
}
