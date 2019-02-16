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
    
    func matchesType<T>(_ type: T.Type) -> Bool {
        let typeDescription = String(describing: type)
        return self.description == typeDescription
    }
}

extension Type: AutoEquatable {}

extension Type: CustomStringConvertible {
    public var description: String {
        switch self {
        case .array(let type):
            return "Array<\(String(describing: type))>"
        case .dictionary(let keyType, let valueType):
            return "Dictionary<\(String(describing: keyType)), \(String(describing: valueType))>"
        case .function: fatalError()
        case .typeIdentifier(let identifier): return identifier
        case .tuple: fatalError()
        }
    }
}
