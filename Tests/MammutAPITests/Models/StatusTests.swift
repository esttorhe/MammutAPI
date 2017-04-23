//
// Created by Esteban Torres on 17.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class StatusTests: XCTestCase {
    func test_sameStatuses_equal() {
        let date = Date()
        let subject1 = StatusTests.makeStatus(createdAt: date, accountDate: date)
        let subject2 = StatusTests.makeStatus(createdAt: date, accountDate: date)
        XCTAssertEqual(subject1, subject2)
    }

    func test_differentStatuses_notEqual() {
        let subject1 = StatusTests.makeStatus(id: #line)
        let subject2 = StatusTests.makeStatus(id: #line)
        XCTAssertNotEqual(subject1, subject2)
    }
}

// MARK: - Linux Support

extension StatusTests {
    static var allTests: [(String, (StatusTests) -> () throws -> Void)] {
        return [
                ("test_sameStatuses_equal", test_sameStatuses_equal),
                ("test_differentStatuses_notEqual", test_differentStatuses_notEqual)
        ]
    }
}

// MARK: - Internal helpers

internal extension StatusTests {
    static func makeStatus(
            id: Int = Int.max,
            createdAt: Date = Date(),
            visibility: StatusVisibility = .public,
            accountDate: Date = Date()
    ) -> Status {
        return Status(
                id: id,
                createdAt: createdAt,
                inReplyToId: nil,
                inReplyToAccountId: nil,
                sensitive: false,
                spoilerText: nil,
                visibility: visibility,
                application: nil,
                account: AccountTests.makeAccount(createdAt: accountDate),
                mediaAttachments: [],
                mentions: [],
                tags: [],
                uri: #file,
                content: #file,
                url: URL(string: "www.example.com")!,
                reblogsCount: 0,
                favouritesCount: 0,
                reblog: nil,
                favourited: true,
                reblogged: false
        )
    }
}
