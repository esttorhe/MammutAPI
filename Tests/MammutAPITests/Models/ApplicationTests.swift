//
// Created by Esteban Torres on 18.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class ApplicationTests: XCTestCase {
    func test_sameApplications_equal() {
        let subject1 = Application(name: #file, website: nil)
        let subject2 = Application(name: #file, website: nil)
        XCTAssertEqual(subject1, subject2)
    }

    func test_differentApplications_notEqual() {
        let subject1 = Application(name: #file, website: #function)
        let subject2 = Application(name: #function, website: #file)
        XCTAssertNotEqual(subject1, subject2)
    }
}

// MARK: - Linux Support

extension ApplicationTests {
    static var allTests: [(String, (ApplicationTests) -> () throws -> Void)] {
        return [
                ("test_sameApplications_equal", test_sameApplications_equal),
                ("test_differentApplications_notEqual", test_differentApplications_notEqual)
        ]
    }
}
