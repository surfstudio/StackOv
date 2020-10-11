import XCTest
@testable import Network

final class NetworkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Network().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
