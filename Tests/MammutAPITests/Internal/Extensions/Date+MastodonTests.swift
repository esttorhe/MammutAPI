//
// Created by Esteban Torres on 17.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class DateTests: XCTestCase {
    func test_mastodonDateFormatter_setsCorrectValues() {
        let dateFormatter = DateFormatter.mastodonDateFormatter()
        XCTAssertEqual(dateFormatter.dateFormat, "yyyy-MM-dd'T'HH:mm:ss.SZ")
        XCTAssertEqual(dateFormatter.timeZone, TimeZone(abbreviation: "UTC"))
        XCTAssertEqual(dateFormatter.locale.identifier, "en_US_POSIX")
    }

    func test_dateInit_invalidString_returnsNil() {
        let invalidInput = "2017-01-01T13:40:55"
        let date = Date(from: invalidInput)
        XCTAssertNil(date)
    }

    func test_dateInit_correctString_returnsDate() {
        let validInput = "2017-04-17T19:07:24.555Z"
        let date = Date(from: validInput)
        XCTAssertNotNil(date)
    }
}

// MARK: - Linux Support

extension DateTests {
    static var allTests: [(String, (DateTests) -> () throws -> Void)] {
        return [
                ("test_mastodonDateFormatter_setsCorrectValues", test_mastodonDateFormatter_setsCorrectValues),
                ("test_dateInit_invalidString_returnsNil", test_dateInit_invalidString_returnsNil),
                ("test_dateInit_correctString_returnsDate", test_dateInit_correctString_returnsDate)
        ]
    }
}
