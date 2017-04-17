//
// Created by Esteban Torres on 15.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
@testable import MammutAPI

internal enum MockError: CustomNSError {
    case customNSError

    public private(set) static var errorDomain: String = "es.estebantorr.MammutAPITests"
    public var errorCode: Int {
        return Int.min
    }
    public var errorUserInfo: [String: Any] {
        return [:]
    }

    static var testError: NSError {
        return NSError(domain: "es.estebantorr.MammutAPITests", code: Int.max, userInfo: [NSLocalizedDescriptionKey: "I am an error"])
    }

    static var boomError: NSError {
        return NSError(domain: "es.estebantorr.MammutAPITests", code: Int.min)
    }
}
