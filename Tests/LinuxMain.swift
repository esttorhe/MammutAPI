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
        testCase(ApplicationMapperTests.allTests),
        testCase(AttachmentMapperTests.allTests),
        testCase(MentionMapperTests.allTest),
        testCase(TagMapperTests.allTests),
        // Models
        testCase(AccountTests.allTests),
        testCase(StatusTests.allTests),
        testCase(ApplicationTests.allTests),
        testCase(AttachmentTests.allTests),
        testCase(MentionTests.allTests),
        testCase(TagTests.allTests)
])
#endif
