import XCTest
@testable import UsersFlow

final class UsersFlowTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(UsersFlow().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
