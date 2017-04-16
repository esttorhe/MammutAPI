
#if os(Linux)
import XCTest
@testable import MammutAPITests

XCTMain([
    testCase(EndpointRequestTests.allTests),
    testCase(MammutErrorTests.allTests)
])
#endif
