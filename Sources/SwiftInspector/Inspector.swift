//
//  Inspector.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/29/18.
//

import Foundation

protocol Inspector {
    func inspect(_ statement: Statement)
}

protocol Inspectable {
    func accept(_ inspector: Inspector)
}

public class SomeInspector: Inspector {
    func inspect(_ statement: Statement) {
        switch statement {
        case .expression(let expr):
            print(expr)
            print("-----")
        }
    }
}
