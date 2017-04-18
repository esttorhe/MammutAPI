//
// Created by Esteban Torres on 18.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class ApplicationMapperTests: XCTestCase {
    var subject: ApplicationMapper!

    override func setUp() {
        subject = ApplicationMapper()
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
        let data = try? Fixture.loadData(from: "Application.json")
        XCTAssertNotNil(data)
        let result = subject.map(data: data!)
        XCTAssertNil(result.error)
        XCTAssertNotNil(result.value)
    }

    func test_map_validData_success_withExpectedValues() {
        let fileName = "Application.json"
        let data = try? Fixture.loadData(from: fileName)
        let expectedData = try? Fixture.loadJSON(from: fileName)
        XCTAssertNotNil(expectedData)
        let result = subject.map(data: data!)
        if case .success(let application) = result {
            XCTAssertEqual(application.name, expectedData!["name"] as! String)
            XCTAssertEqual(application.website, expectedData!["website"] as? String)
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
        let json = try? Fixture.loadJSON(from: "Application.json")
        XCTAssertNotNil(json)
        let result = subject.map(json: json!)
        XCTAssertNil(result.error)
        XCTAssertNotNil(result.value)
    }

    func test_map_validJSON_success_withExpectedValues() {
        let fileName = "Application.json"
        let json = try? Fixture.loadJSON(from: fileName)
        let expectedData = try? Fixture.loadJSON(from: fileName)
        XCTAssertNotNil(expectedData)
        let result = subject.map(json: json!)
        if case .success(let application) = result {
            XCTAssertEqual(application.name, expectedData!["name"] as! String)
            XCTAssertEqual(application.website, expectedData!["website"] as? String)
        } else {
            XCTFail("Should have returned a parsed «Status»")
        }
    }

    func test_mapData_mapJSON_producesSameModel() {
        let fileName = "Application.json"
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
}

// MARK: - Linux Support

extension ApplicationMapperTests {
    static var allTests: [(String, (ApplicationMapperTests) -> () throws -> Void)] {
        return [
                ("test_map_emptyData_failure_invalidJSON", test_map_emptyData_failure_invalidJSON),
                ("test_map_invalidData_failure_incompleteModel", test_map_invalidData_failure_incompleteModel),
                ("test_map_validData_success", test_map_validData_success),
                ("test_map_validData_success_withExpectedValues", test_map_validData_success_withExpectedValues),
                ("test_map_invalidJSON_failure_incompleteModel", test_map_invalidJSON_failure_incompleteModel),
                ("test_map_validJSON_success", test_map_validJSON_success),
                ("test_map_validJSON_success_withExpectedValues", test_map_validJSON_success_withExpectedValues),
                ("test_mapData_mapJSON_producesSameModel", test_mapData_mapJSON_producesSameModel)
        ]
    }
}
