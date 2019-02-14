//
//  Type.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 2/11/19.
//

import Foundation

public indirect enum Type {
    case array(Type)
    case dictionary(Type, Type)
    case function
    case typeIdentifier(identifier: String)
    case tuple
}

extension Type: AutoEquatable {}
