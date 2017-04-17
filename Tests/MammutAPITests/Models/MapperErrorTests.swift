//
// Created by Esteban Torres on 17.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import XCTest
@testable import MammutAPI

internal class MapperErrorTests: XCTestCase {
    func test_casesWithoutAssociatedType_equal() {
        var lhs: MammutAPIError.MappingError
        var rhs: MammutAPIError.MappingError

        lhs = .incompleteModel
        rhs = .incompleteModel
        XCTAssertEqual(lhs, rhs)

        lhs = .invalidJSON
        rhs = .invalidJSON
        XCTAssertEqual(lhs, rhs)
    }

    func test_casesWithouthAssociatedType_notEqual() {
        var lhs: MammutAPIError.MappingError
        var rhs: MammutAPIError.MappingError

        lhs = .incompleteModel
        rhs = .invalidJSON
        XCTAssertNotEqual(lhs, rhs)

        lhs = .invalidJSON
        rhs = .incompleteModel
        XCTAssertNotEqual(lhs, rhs)
    }

    func test_convertToNSError_setsCorrectErrorDomain() {
        let expectedErrorDomain = "me.estebantorr.MammutAPI.MappingError"
        let subject = MammutAPIError.MappingError.incompleteModel
        let nsSubject = NSError(mappingError: subject)
        XCTAssertEqual(nsSubject.domain, expectedErrorDomain)
    }

    func test_convertToNSError_setsCorrectErrorCodeForEachCase() {
        var subject: MammutAPIError.MappingError
        var nsSubject: NSError

        subject = .incompleteModel
        nsSubject = NSError(mappingError: subject)
        XCTAssertEqual(nsSubject.code, -1)

        subject = .invalidJSON
        nsSubject = NSError(mappingError: subject)
        XCTAssertEqual(nsSubject.code, -2)
    }

    func test_convertToNSError_setsCorrectLocalizedDescriptionForEachCase() {
        var subject: MammutAPIError.MappingError
        var nsSubject: NSError

        subject = .incompleteModel
        nsSubject = NSError(mappingError: subject)
        XCTAssertEqual(nsSubject.localizedDescription, subject.description)

        subject = .invalidJSON
        nsSubject = NSError(mappingError: subject)
        XCTAssertEqual(nsSubject.localizedDescription, subject.description)
    }

    func test_description_doesntReturnEmptyStrings() {
        XCTAssertGreaterThan(MammutAPIError.MappingError.incompleteModel.description.characters.count, 0)
        XCTAssertGreaterThan(MammutAPIError.MappingError.invalidJSON.description.characters.count, 0)
    }
}

// MARK: - Linux support

extension MapperErrorTests {
    static var allTests: [(String, (MapperErrorTests) -> () throws -> Void)] {
        return [
                ("test_casesWithoutAssociatedType_equal", test_casesWithoutAssociatedType_equal),
                ("test_convertToNSError_setsCorrectErrorDomain", test_convertToNSError_setsCorrectErrorDomain),
                ("test_convertToNSError_setsCorrectErrorCodeForEachCase", test_convertToNSError_setsCorrectErrorCodeForEachCase),
                ("test_convertToNSError_setsCorrectLocalizedDescriptionForEachCase", test_convertToNSError_setsCorrectLocalizedDescriptionForEachCase),
                ("test_description_doesntReturnEmptyStrings", test_description_doesntReturnEmptyStrings),
                ("test_casesWithouthAssociatedType_notEqual", test_casesWithouthAssociatedType_notEqual)
        ]
    }
}
