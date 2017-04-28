//
// Created by Esteban Torres on 24.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class InstanceTests: XCTestCase {
    func test_sameInstances_equal() {
        let subject1 = InstanceTests.makeInstance()
        let subject2 = InstanceTests.makeInstance()
        XCTAssertEqual(subject1, subject2)
    }

    func test_differentInstances_notEqual() {
        let subject1 = InstanceTests.makeInstance(title: #function + #file)
        let subject2 = InstanceTests.makeInstance(title: #file + #function)
        XCTAssertNotEqual(subject1, subject2)
    }
}

// MARK: - Linux Support

extension InstanceTests {
    static var allTests: [(String, (InstanceTests) -> () throws -> Void)] {
        return [
                ("test_sameInstances_equal", test_sameInstances_equal),
                ("test_differentInstances_notEqual", test_differentInstances_notEqual)
        ]
    }
}

// MARK: Test Helpers

fileprivate extension InstanceTests {
    static func makeInstance(uri: String = "www.example.com", title: String = #file, description: String = #file, email: String = #file) -> Instance {
        return Instance(
                uri: uri,
                title: title,
                description: description,
                email: email
        )
    }
}
