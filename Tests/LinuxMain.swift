import XCTest

import FlameGraphTests

var tests = [XCTestCaseEntry]()
tests += FlameGraphTests.allTests()
XCTMain(tests)
