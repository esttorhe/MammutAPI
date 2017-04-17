//
// Created by Esteban Torres on 17.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class NSErrorConvertibleTests: XCTestCase {
    struct BlehError: Error {}

    func test_initError_withCustomNSError_returnsNSError() {
        let subject = NSError(error: MockError.customNSError)
        XCTAssertEqual(subject.domain, "es.estebantorr.MammutAPITests")
        XCTAssertEqual(subject.code, Int.min)
    }

    func test_initError_withNonCustomNSError_returnsUncastableError() {
        let subject = NSError(error: BlehError())
        XCTAssertEqual(subject.domain, "es.estebantorr.MammutAPI.Core")
        XCTAssertEqual(subject.code, Int.max)
        XCTAssertTrue(subject.localizedDescription.contains("Received an «Error» that cannot be casted to «NSError»:"))
    }

    func test_initCustomNSError_withCustomNSError_returnsNSError() {
        let error = MockError.customNSError as? Error
        XCTAssertNotNil(error)
        let subject = NSError(error: error!)
        XCTAssertEqual(subject.domain, "es.estebantorr.MammutAPITests")
        XCTAssertEqual(subject.code, Int.min)
    }
}

// MARK: - Linux Support

extension NSErrorConvertibleTests {
    static var allTest: [(String, (NSErrorConvertibleTests) -> () throws -> Void)] {
        return [
                ("test_initError_withCustomNSError_returnsNSError", test_initError_withCustomNSError_returnsNSError),
                ("test_initError_withNonCustomNSError_returnsUncastableError", test_initError_withNonCustomNSError_returnsUncastableError),
                ("test_initCustomNSError_withCustomNSError_returnsNSError", test_initCustomNSError_withCustomNSError_returnsNSError)
        ]
    }
}
