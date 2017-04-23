//
// Created by Esteban Torres on 23.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class TagTests: XCTestCase {
    func test_sameMentions_equal() {
        let subject1 = TagTests.makeTag()
        let subject2 = TagTests.makeTag()
        XCTAssertEqual(subject1, subject2)
    }

    func test_differentMentions_notEqual() {
        let subject1 = TagTests.makeTag(name: #function + #file)
        let subject2 = TagTests.makeTag(name: #file + #function)
        XCTAssertNotEqual(subject1, subject2)
    }
}

// MARK: - Linux Support

extension TagTests {
    static var allTests: [(String, (TagTests) -> () throws -> Void)] {
        return [
                ("test_sameMentions_equal", test_sameMentions_equal),
                ("test_differentMentions_notEqual", test_differentMentions_notEqual)
        ]
    }
}

// MARK: Test Helpers

fileprivate extension TagTests {
    static func makeTag(name: String = #file, url: URL = URL(string: "www.example.com")!) -> Tag {
        return Tag(
                name: name,
                url: url
        )
    }
}
