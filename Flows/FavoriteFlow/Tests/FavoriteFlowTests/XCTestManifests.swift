import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FavoriteFlowTests.allTests),
    ]
}
#endif
