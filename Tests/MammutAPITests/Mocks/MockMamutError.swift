//
// Created by Esteban Torres on 15.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
@testable import MammutAPI

internal enum MockError {
    static var testError: NSError {
        return NSError(domain: "me.estebantorr.MammutAPITests", code: Int.max)
    }

    static var boomError: NSError {
        return NSError(domain: "me.estebantorr.MammutAPITests", code: Int.min)
    }
}
