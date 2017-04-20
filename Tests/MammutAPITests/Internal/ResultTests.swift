//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class ResultTests: XCTestCase {
    var subject: Result<Int, NSError>!

    func test_value_isNilForFailure() throws {
        subject = .failure(MockError.testError)
        XCTAssertNil(subject.value)
    }

    func test_value_isSuccess_returnsCorrectValue() throws {
        subject = .success(Int.max)
        XCTAssertEqual(Int.max, subject.value)
    }

    func test_error_isNilForSuccess() throws {
        subject = .success(Int.min)
        XCTAssertNil(subject.error)
    }

    func test_error_isNotNilForFailure() throws {
        subject = .failure(MockError.testError)
        XCTAssertNotNil(subject.error)
    }

    func test_error_isFailure_returnsCorrectError() throws {
        subject = .failure(MockError.testError)
        let error: NSError = try AssertNotNilAndUnwrap(subject.error)
        XCTAssertEqual(MockError.testError.code, error.code)
        XCTAssertEqual(MockError.testError.domain, error.domain)
        XCTAssertEqual(MockError.testError.localizedDescription, error.localizedDescription)
    }

    func test_flatMap_isFailure_returnsSameFailure() throws {
        subject = .failure(MockError.testError)
        let result = subject.flatMap { return .success($0) }
        XCTAssertEqual(subject.error, result.error)
    }

    func test_flatMap_isSuccess_returnsFuncAppliedToSuccess() throws {
        subject = .success(Int.max)
        let result = subject.flatMap { return .success($0) }
        XCTAssertEqual(Int.max, result.value)
    }

    func test_flatMap_isSuccess_functionIsNotHardcoded() throws {
        subject = .success(777)
        let result = subject.flatMap { return .success(String($0)) }
        XCTAssertEqual("777", result.value)
    }
}

// MARK: - Linux support

extension ResultTests {
    static var allTests: [(String, (ResultTests) -> () throws -> Void)] {
        return [
                ("test_value_isNilForFailure", test_value_isNilForFailure),
                ("test_value_isSuccess_returnsCorrectValue", test_value_isSuccess_returnsCorrectValue),
                ("test_error_isNilForSuccess", test_error_isNilForSuccess),
                ("test_error_isNotNilForFailure", test_error_isNotNilForFailure),
                ("test_error_isFailure_returnsCorrectError", test_error_isFailure_returnsCorrectError),
                ("test_flatMap_isFailure_returnsSameFailure", test_flatMap_isFailure_returnsSameFailure),
                ("test_flatMap_isSuccess_returnsFuncAppliedToSuccess", test_flatMap_isSuccess_returnsFuncAppliedToSuccess),
                ("test_flatMap_isSuccess_functionIsNotHardcoded", test_flatMap_isSuccess_functionIsNotHardcoded)
        ]
    }
}
