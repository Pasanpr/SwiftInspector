import XCTest
@testable import SwiftInspector

final class SwiftInspectorTests: XCTestCase {
    var inspector: SwiftInspector!
    
    func testVarDeclaration() {
        let source = "var foo = \"bar\""
        
        inspector = try! SwiftInspector(source: source)
        
        XCTAssertTrue(inspector.contains(.variable, named: "foo"))
    }
    
    func testLetDeclaration() {
        let source = "let foo = \"bar\""
        inspector = try! SwiftInspector(source: source)
//        XCTAssertTrue(inspector.contains(.constant, named: "foo"))
    }
}
