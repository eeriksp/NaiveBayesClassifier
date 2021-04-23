import XCTest

import bayesTests

var tests = [XCTestCaseEntry]()
tests += bayesTests.allTests()
XCTMain(tests)
