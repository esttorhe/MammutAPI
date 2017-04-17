//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class TimelinesTests: XCTestCase {
    func test_casesWithNoAssociatedValueEquality_equal() {
        var sutLhs: Endpoint.Timeline
        var sutRhs: Endpoint.Timeline

        sutLhs = .home
        sutRhs = .home
        XCTAssertEqual(sutLhs, sutRhs)

        sutLhs = .local
        sutRhs = .local
        XCTAssertEqual(sutLhs, sutRhs)
    }

    func test_casesWithNoAssociatedValueEquality_notEqual() {
        let sutLhs: Endpoint.Timeline = .local
        let sutRhs: Endpoint.Timeline = .home
        XCTAssertNotEqual(sutLhs, sutRhs)
    }

    func test_tagWithSameTextEquality_equal() {
        let sutLhs = Endpoint.Timeline.tag("test")
        let sutRhs = Endpoint.Timeline.tag("test")
        XCTAssertEqual(sutLhs, sutRhs)
    }

    func test_tagWithDifferentTextEquality_notEqual() {
        let sutLhs = Endpoint.Timeline.tag("test")
        let sutRhs = Endpoint.Timeline.tag("anotherTag")
        XCTAssertNotEqual(sutLhs, sutRhs)
    }

    func test_tagNoAssociatedTypeWithAssociatedTypeEquality_notEqual() {
        XCTAssertNotEqual(Endpoint.Timeline.local, Endpoint.Timeline.tag("tag"))
        XCTAssertNotEqual(Endpoint.Timeline.home, Endpoint.Timeline.tag("tag"))
    }

    func test_path_isNotNil() {
        XCTAssertNotNil(Endpoint.Timeline.local.path)
        XCTAssertNotNil(Endpoint.Timeline.home.path)
        XCTAssertNotNil(Endpoint.Timeline.tag("tag").path)
    }

    func test_path_containsTimelinesAsBase() {
        XCTAssertTrue(Endpoint.Timeline.local.path!.hasPrefix(Endpoint.Timeline.timelinePath))
        XCTAssertTrue(Endpoint.Timeline.home.path!.hasPrefix(Endpoint.Timeline.timelinePath))
        XCTAssertTrue(Endpoint.Timeline.tag("tag").path!.hasPrefix(Endpoint.Timeline.timelinePath))
    }

    func test_method_inAllCases_isGet() {
        XCTAssertEqual(Method.get, Endpoint.Timeline.local.method)
        XCTAssertEqual(Method.get, Endpoint.Timeline.home.method)
        XCTAssertEqual(Method.get, Endpoint.Timeline.tag("tag").method)
    }

    func test_validResponseCodes_inAllCases_isRangeBetween200_300() {
        XCTAssertEqual(200..<300, Endpoint.Timeline.local.validResponseCodes)
        XCTAssertEqual(200..<300, Endpoint.Timeline.home.validResponseCodes)
        XCTAssertEqual(200..<300, Endpoint.Timeline.tag("tag").validResponseCodes)
    }
}

// MARK: - Linux Support

extension TimelinesTests {
    static var allTests: [(String, (TimelinesTests) -> () throws -> Void)] {
        return [
                ("test_casesWithNoAssociatedValueEquality_equal", test_casesWithNoAssociatedValueEquality_equal),
                ("test_casesWithNoAssociatedValueEquality_notEqual", test_casesWithNoAssociatedValueEquality_notEqual),
                ("test_tagWithSameTextEquality_equal", test_tagWithSameTextEquality_equal),
                ("test_tagWithDifferentTextEquality_notEqual", test_tagWithDifferentTextEquality_notEqual),
                ("test_tagNoAssociatedTypeWithAssociatedTypeEquality_notEqual", test_tagNoAssociatedTypeWithAssociatedTypeEquality_notEqual),
                ("test_path_isNotNil", test_path_isNotNil),
                ("test_path_containsTimelinesAsBase", test_path_containsTimelinesAsBase),
                ("test_method_inAllCases_isGet", test_method_inAllCases_isGet),
                ("test_validResponseCodes_inAllCases_isRangeBetween200_300", test_validResponseCodes_inAllCases_isRangeBetween200_300)
        ]
    }
}
