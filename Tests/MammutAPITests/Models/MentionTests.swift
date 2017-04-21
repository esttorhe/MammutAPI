//
// Created by Esteban Torres on 21.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class MentionTests: XCTestCase {
    func test_sameMentions_equal() {
        let subject1 = MentionTests.makeMention(id: Int.max)
        let subject2 = MentionTests.makeMention(id: Int.max)
        XCTAssertEqual(subject1, subject2)
    }

    func test_differentMentions_notEqual() {
        let subject1 = MentionTests.makeMention(id: #line)
        let subject2 = MentionTests.makeMention(id: #line)
        XCTAssertNotEqual(subject1, subject2)
    }
}

// MARK: - Linux Support

extension MentionTests {
    static var allTests: [(String, (MentionTests) -> () throws -> Void)] {
        return [
                ("test_sameMentions_equal", test_sameMentions_equal),
                ("test_differentMentions_notEqual", test_differentMentions_notEqual)
        ]
    }
}

// MARK: Test Helpers

fileprivate extension MentionTests {
    static func makeMention(id: Int = #line, url: URL = URL(string: "www.example.com")!, username: String = #file, acct: String = #file) -> Mention {
        return Mention(
                id: id,
                url: url,
                username: username,
                acct: acct
        )
    }
}
