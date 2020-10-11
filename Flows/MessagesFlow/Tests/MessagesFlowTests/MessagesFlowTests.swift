import XCTest
@testable import MessagesFlow

final class MessagesFlowTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MessagesFlow().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
