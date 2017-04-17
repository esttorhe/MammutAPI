#if os(Linux)

import XCTest
@testable import MammutAPITests

XCTMain([
        // Error
        testCase(NetworkErrorTests.allTests),
        testCase(MapperErrorTests.allTests),
        testCase(NSErrorConvertibleTests.allTest),
        // Endpoint
        testCase(EndpointRequestTests.allTests),
        testCase(TimelinesTests.allTests),
        // Internal/Helper
        testCase(ResultTests.allTests),
        testCase(DateTests.allTests),
        // Mappers
        testCase(AccountMapperTests.allTests),
        testCase(StatusMapperTests.allTests),
        // Models
        testCase(AccountTests.allTests),
        testCase(StatusTests.allTests)
])
#endif
