import XCTest

import MarkdownTests

var tests = [XCTestCaseEntry]()
tests += MarkdownTests.allTests()
XCTMain(tests)
