
#if os(Linux)
import XCTest
@testable import MammutAPITests

XCTMain([
        testCase(EndpointRequestTests.allTests),
        testCase(NetworkErrorTests.allTests),
        testCase(ResultTests.allTests),
        testCase(TimelinesTests.allTests),
        testCase(MapperErrorTests.allTests),
        testCase(DateTests.allTests)
])
#endif
