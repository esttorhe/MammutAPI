//
// Created by Esteban Torres on 17.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class StatusMapperTests: XCTestCase {
    var subject: StatusMapper!

    override func setUp() {
        subject = StatusMapper()
    }

    // MARK: `data` mapping tests
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
        let data = try? Fixture.loadData(from: "Status.json")
        XCTAssertNotNil(data)
        let result = subject.map(data: data!)
        XCTAssertNil(result.error)
        XCTAssertNotNil(result.value)
    }

    func test_map_validData_success_withExpectedValues() {
        let fileName = "Status.json"
        let data = try? Fixture.loadData(from: fileName)
        let expectedData = try? Fixture.loadJSON(from: fileName)
        XCTAssertNotNil(expectedData)
        let result = subject.map(data: data!)
        if case .success(let account) = result {
            XCTAssertEqual(account.id, expectedData!["id"] as! Int)
        } else {
            XCTFail("Should have returned a parsed «Status»")
        }
    }

    // MARK: `json` mapping tests

    func test_map_invalidJSON_failure_incompleteModel() {
        let json = try? Fixture.loadJSON(from: "IncompleteJSON.json")
        XCTAssertNotNil(json)
        let result = subject.map(json: json!)
        XCTAssertNotNil(result.error)
        XCTAssertNil(result.value)
        XCTAssertEqual(result.error!, MammutAPIError.MappingError.incompleteModel)
    }

    func test_map_validJSON_success() {
        let json = try? Fixture.loadJSON(from: "Status.json")
        XCTAssertNotNil(json)
        let result = subject.map(json: json!)
        XCTAssertNil(result.error)
        XCTAssertNotNil(result.value)
    }

    func test_map_validJSON_success_withExpectedValues() {
        let fileName = "Status.json"
        let json = try? Fixture.loadJSON(from: fileName)
        let expectedData = try? Fixture.loadJSON(from: fileName)
        XCTAssertNotNil(expectedData)
        let result = subject.map(json: json!)
        if case .success(let account) = result {
            XCTAssertEqual(account.id, expectedData!["id"] as! Int)
        } else {
            XCTFail("Should have returned a parsed «Status»")
        }
    }

    func test_mapData_mapJSON_producesSameModel() {
        let fileName = "Status.json"
        let json = try? Fixture.loadJSON(from: fileName)
        let data = try? Fixture.loadData(from: fileName)
        XCTAssertNotNil(json)
        XCTAssertNotNil(data)

        let mappedFromJSON = subject.map(json: json!)
        let mappedFromData = subject.map(data: data!)
        XCTAssertNotNil(mappedFromData.value)
        XCTAssertNotNil(mappedFromJSON.value)
        XCTAssertEqual(mappedFromJSON.value!, mappedFromData.value!)
    }

    func test_map_jsonWithoutApplication_setsApplicationToNil() {
        let fileName = "Status.json"
        let json = try? Fixture.loadJSON(from: fileName)
        let result = subject.map(json: json!)
        XCTAssertNil(result.error)
        XCTAssertNil(result.value!.application)
    }

    func test_map_jsonWithApplication_setsApplicationToValidApplicationObject() {
        let fileName = "StatusWithApplication.json"
        let json = try? Fixture.loadJSON(from: fileName)
        let result = subject.map(json: json!)
        XCTAssertNil(result.error)
        XCTAssertNotNil(result.value!.application)
    }
}

// MARK: - Linux Support

extension StatusMapperTests {
    static var allTests: [(String, (StatusMapperTests) -> () throws -> Void)] {
        return [
                ("test_map_emptyData_failure_invalidJSON", test_map_emptyData_failure_invalidJSON),
                ("test_map_invalidData_failure_incompleteModel", test_map_invalidData_failure_incompleteModel),
                ("test_map_validData_success", test_map_validData_success),
                ("test_map_validData_success_withExpectedValues", test_map_validData_success_withExpectedValues),
                ("test_map_invalidJSON_failure_incompleteModel", test_map_invalidJSON_failure_incompleteModel),
                ("test_map_validJSON_success", test_map_validJSON_success),
                ("test_map_validJSON_success_withExpectedValues", test_map_validJSON_success_withExpectedValues),
                ("test_mapData_mapJSON_producesSameModel", test_mapData_mapJSON_producesSameModel),
                ("test_map_jsonWithoutApplication_setsApplicationToNil", test_map_jsonWithoutApplication_setsApplicationToNil),
                ("test_map_jsonWithApplication_setsApplicationToValidApplicationObject", test_map_jsonWithApplication_setsApplicationToValidApplicationObject)
        ]
    }
}
