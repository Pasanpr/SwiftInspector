import Foundation

public class SwiftInspector {
    let program: Program
    
    init(source: String) throws {
        let parser = SwiftParser(contentsOfFile: source)
        self.program = try parser.generateAST()
    }
    
    public enum Declaration {
        case variable
    }
    
    public func contains(_ declaration: Declaration, named name: String) -> Bool {
        for statement in program.statements {
            switch statement {
            case .expression:
                return false
            case .declaration(let declr):
                switch declr {
                case .variable(let identifierExpr, _, let expr):
                    switch identifierExpr {
                    case .identifier(let varName, let genericArgs):
                        if varName == name {
                            return true
                        } else {
                            return false
                        }
                    default:
                        return false
                    }
                default:
                    return false
                }
            }
        }
        
        return false
    }
}
