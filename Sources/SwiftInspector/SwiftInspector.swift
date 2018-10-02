import Foundation

class SwiftInspector {
    let program: Program
    
    init(source: String) throws {
        let lexer = Lexer(source: source)
        let tokens = try lexer.scan()
        let parser = Parser(tokens: tokens)
        self.program = try parser.parse()
    }
}
