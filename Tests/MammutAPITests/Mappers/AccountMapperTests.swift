//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class AccountMapperTests: XCTestCase {
    var subject: AccountMapper!

    override func setUp() {
        subject = AccountMapper()
    }

    func test_map_emptyData_failure_invalidJSON() {
        let result = subject.map(data: Data())
        XCTAssertNotNil(result.error)
        XCTAssertEqual(result.error!, MammutAPIError.MappingError.invalidJSON)
    }

    func test_map_invalidData_failure_incompleteModel() {
        let data = try? Fixture.loadData(from: "IncompleteJSON.json")
        XCTAssertNotNil(data)
        let result = subject.map(data: data!)
        XCTAssertNotNil(result.error)
        XCTAssertNil(result.value)
        XCTAssertEqual(result.error!, MammutAPIError.MappingError.incompleteModel)
    }

    func test_map_validData_success() {
        let data = try? Fixture.loadData(from: "Account.json")
        XCTAssertNotNil(data)
        let result = subject.map(data: data!)
        XCTAssertNil(result.error)
        XCTAssertNotNil(result.value)
    }

    func test_map_validData_success_withExpectedValues() {
        let fileName = "Account.json"
        let data = try? Fixture.loadData(from: fileName)
        let expectedData = try? Fixture.loadJSON(from: fileName)
        XCTAssertNotNil(expectedData)
        let result = subject.map(data: data!)
        if case .success(let account) = result {
            XCTAssertEqual(account.id, expectedData!["id"] as! Int)
        } else {
            XCTFail("Should have returned a parsed «Account»")
        }
    }
}

// MARK: - Linux Support

extension AccountMapperTests {
    static var allTests: [(String, (AccountMapperTests) -> () throws -> Void)] {
        return [
                ("test_map_emptyData_failure_invalidJSON", test_map_emptyData_failure_invalidJSON),
                ("test_map_invalidData_failure_incompleteModel", test_map_invalidData_failure_incompleteModel),
                ("test_map_validData_success", test_map_validData_success),
                ("test_map_validData_success_withExpectedValues", test_map_validData_success_withExpectedValues)
        ]
    }
}
