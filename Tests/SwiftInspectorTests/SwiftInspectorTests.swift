import XCTest
@testable import SwiftInspector

final class SwiftInspectorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftInspector().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
