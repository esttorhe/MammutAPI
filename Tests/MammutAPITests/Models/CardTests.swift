//
// Created by Esteban Torres on 23.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class CardTests: XCTestCase {
    func test_sameCards_equal() {
        let subject1 = CardTests.makeCard()
        let subject2 = CardTests.makeCard()
        XCTAssertEqual(subject1, subject2)
    }

    func test_differentCards_notEqual() {
        let subject1 = CardTests.makeCard(url: URL(string: "www.example.com")!)
        let subject2 = CardTests.makeCard(url: URL(string: "www.example-not.com")!)
        XCTAssertNotEqual(subject1, subject2)
    }
}

// MARK: - Linux Support

extension CardTests {
    static var allTests: [(String, (CardTests) -> () throws -> Void)] {
        return [
                ("test_sameCards_equal", test_sameCards_equal),
                ("test_differentCards_notEqual", test_differentCards_notEqual)
        ]
    }
}

// MARK: Test Helpers

fileprivate extension CardTests {
    static func makeCard(title: String = #file, url: URL = URL(string: "www.example.com")!, description: String = #file, image: URL? = nil) -> Card {
        return Card(
                url: url,
                title: title,
                description: description,
                image: image
        )
    }
}
