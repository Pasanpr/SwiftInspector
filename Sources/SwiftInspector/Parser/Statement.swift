//
//  Statement.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

enum Statement {
    case expression(Expression)
}

extension Statement: Printable {
    func accept(printer: Printer) -> String {
        return printer.processStatement(self)
    }
}

extension Statement: Inspectable {
    func accept(_ inspector: Inspector) {
        inspector.inspect(self)
    }
}
