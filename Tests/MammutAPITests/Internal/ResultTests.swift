//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

internal class ResultTests: XCTestCase {
    var subject: Result<Int, NSError>!

    func test_value_isNilForFailure() {
        subject = .failure(MockError.testError)
        XCTAssertNil(subject.value)
    }

    func test_value_isSuccess_returnsCorrectValue() {
        subject = .success(Int.max)
        XCTAssertEqual(Int.max, subject.value)
    }

    func test_error_isNilForSuccess() {
        subject = .success(Int.min)
        XCTAssertNil(subject.error)
    }

    func test_error_isNotNilForFailure() {
        subject = .failure(MockError.testError)
        XCTAssertNotNil(subject.error)
    }

    func test_error_isFailure_returnsCorrectError() {
        subject = .failure(MockError.testError)
        XCTAssertNotNil(subject.error)
        XCTAssertEqual(MockError.testError, subject.error!)
    }

    func test_flatMap_isFailure_returnsSameFailure() {
        subject = .failure(MockError.testError)
        let result = subject.flatMap { return .success($0) }
        XCTAssertEqual(subject.error, result.error)
    }

    func test_flatMap_isSuccess_returnsFuncAppliedToSuccess() {
        subject = .success(Int.max)
        let result = subject.flatMap { return .success($0) }
        XCTAssertEqual(Int.max, result.value)
    }

    func test_flatMap_isSuccess_functionIsNotHardcoded() {
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
