//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
@testable import MammutAPI
import XCTest

internal class MammutErrorTests: XCTestCase {
    func test_casesWithoutAssociatedType_equal() {
        var lhs: MammutAPIError.NetworkError
        var rhs: MammutAPIError.NetworkError

        lhs = .malformedURL
        rhs = .malformedURL
        XCTAssertEqual(lhs, rhs)

        lhs = .invalidJSON
        rhs = .invalidJSON
        XCTAssertEqual(lhs, rhs)

        lhs = .emptyResponse
        rhs = .emptyResponse
        XCTAssertEqual(lhs, rhs)
    }

    func test_casesWithoutAssociatedType_notEqual() {
        var lhs: MammutAPIError.NetworkError
        var rhs: MammutAPIError.NetworkError

        lhs = .malformedURL
        rhs = .emptyResponse
        XCTAssertNotEqual(lhs, rhs)

        lhs = .malformedURL
        rhs = .invalidJSON
        XCTAssertNotEqual(lhs, rhs)

        lhs = .emptyResponse
        rhs = .invalidJSON
        XCTAssertNotEqual(lhs, rhs)
    }

    func test_different_invalidStatusResponse_notEqual() {
        let response = URLResponse(url: URL(string:"www.example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let lhs = MammutAPIError.NetworkError.invalidStatusCode(nil)
        let rhs = MammutAPIError.NetworkError.invalidStatusCode(response)
        XCTAssertNotEqual(lhs, rhs)
    }

    func test_same_invalidStatusResponse_equal() {
        let lhsResponse = URLResponse(url: URL(string:"www.example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let rhsResponse = URLResponse(url: URL(string:"www.example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let lhs = MammutAPIError.NetworkError.invalidStatusCode(lhsResponse)
        let rhs = MammutAPIError.NetworkError.invalidStatusCode(rhsResponse)
        XCTAssertEqual(lhs, rhs)
    }

    func test_different_serverError_notEqual() {
        let lhsError = MockError.testError
        let rhsError = MockError.boomError
        let lhs = MammutAPIError.NetworkError.serverError(lhsError)
        let rhs = MammutAPIError.NetworkError.serverError(rhsError)
        XCTAssertNotEqual(lhs, rhs)
    }

    func test_same_serverError_equal() {
        let lhsError = MockError.testError
        let rhsError = MockError.testError
        let lhs = MammutAPIError.NetworkError.serverError(lhsError)
        let rhs = MammutAPIError.NetworkError.serverError(rhsError)
        XCTAssertEqual(lhs, rhs)
    }

    func test_convertToNSError_setsCorrectErrorDomain() {
        let expectedErrorDomain = "me.estebantorr.MammutAPI.NetworkError"
        let subject = MammutAPIError.NetworkError.invalidJSON
        let nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.domain, expectedErrorDomain)
    }

    func test_convertToNSError_setsCorrectErrorCodeForEachCase() {
        var subject: MammutAPIError.NetworkError
        var nsSubject: NSError

        subject = .emptyResponse
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.code, -1)

        subject = .serverError(MockError.testError)
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.code, -2)

        subject = .invalidStatusCode(nil)
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.code, -3)

        subject = .invalidJSON
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.code, -4)

        subject = .malformedURL
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.code, -5)
    }

    func test_convertToNSError_setsCorrectLocalizedDescriptionForEachCase() {
        var subject: MammutAPIError.NetworkError
        var nsSubject: NSError

        subject = .emptyResponse
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.localizedDescription, subject.description)

        subject = .serverError(MockError.testError)
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.localizedDescription, subject.description)

        subject = .invalidStatusCode(nil)
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.localizedDescription, subject.description)

        subject = .invalidJSON
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.localizedDescription, subject.description)

        subject = .malformedURL
        nsSubject = NSError(networkError: subject)
        XCTAssertEqual(nsSubject.localizedDescription, subject.description)
    }
}

// MARK: Linux Support

extension MammutErrorTests {
    static var allTests: [(String, (MammutErrorTests) -> () throws -> Void)] {
        return [
                ("test_casesWithoutAssociatedType_equal", test_casesWithoutAssociatedType_equal),
                ("test_casesWithoutAssociatedType_notEqual", test_casesWithoutAssociatedType_notEqual),
                ("test_different_invalidStatusResponse_notEqual", test_different_invalidStatusResponse_notEqual),
                ("test_same_invalidStatusResponse_equal", test_same_invalidStatusResponse_equal),
                ("test_different_serverError_notEqual", test_different_serverError_notEqual),
                ("test_same_serverError_equal", test_same_serverError_equal),
                ("test_convertToNSError_setsCorrectErrorDomain", test_convertToNSError_setsCorrectErrorDomain),
                ("test_convertToNSError_setsCorrectErrorCodeForEachCase", test_convertToNSError_setsCorrectErrorCodeForEachCase),
                ("test_convertToNSError_setsCorrectLocalizedDescriptionForEachCase", test_convertToNSError_setsCorrectLocalizedDescriptionForEachCase)
        ]
    }
}
