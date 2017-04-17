//
// Created by Esteban Torres on 17.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class AccountTests: XCTestCase {
    func test_sameAccounts_equal() {
        let date = Date()
        let subject1 = AccountTests.makeAccount(createdAt: date)
        let subject2 = AccountTests.makeAccount(createdAt: date)
        XCTAssertEqual(subject1, subject2)
    }

    func test_differentAccounts_notEqual() {
        let subject1 = AccountTests.makeAccount(id: #line)
        let subject2 = AccountTests.makeAccount(id: #line)
        XCTAssertNotEqual(subject1, subject2)
    }
}

// MARK: - Linux support

extension AccountTests {
    static var allTests: [(String, (AccountTests) -> () throws -> Void)] {
        return [
                ("test_sameAccounts_equal", test_sameAccounts_equal),
                ("test_differentAccounts_notEqual", test_differentAccounts_notEqual)
        ]
    }
}

// MARK: - Internal helpers

internal extension AccountTests {
    static func makeAccount(id: Int = Int.min, createdAt: Date = Date()) -> Account {
        return Account(
                id: id,
                username: #file,
                acct: #file,
                displayName: #file,
                locked: false,
                createdAt: createdAt,
                followersCount: 0,
                followingCount: 0,
                statusesCount: 0,
                note: #file,
                url: "www.example.com",
                avatar: "www.example.com",
                avatarStatic: "www.example.com",
                header: "www.example.com",
                headerStatic: "www.example.com"
        )
    }
}
