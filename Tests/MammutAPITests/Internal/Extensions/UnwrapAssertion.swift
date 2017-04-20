//
// Created by Esteban Torres on 20.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import XCTest

private struct UnexpectedNilError: Error {}

internal func AssertNotNilAndUnwrap<T>
        (
                _ subject: T?,
                message: String = "Unexpectedly found nil",
                file: StaticString = #file,
                line: UInt = #line
        ) throws -> T {
    guard let subject = subject else {
        XCTFail(message, file: file, line: line)
        throw UnexpectedNilError()
    }

    return subject
}
