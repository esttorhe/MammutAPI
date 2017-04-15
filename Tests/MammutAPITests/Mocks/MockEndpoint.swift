//
// Created by Esteban Torres on 14.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
@testable import MammutAPI

class MockEndpoint: URLProviding {
    let method: MammutAPI.Method
    let path: String?
    let validResponseCodes: Range<Int>

    init(method: MammutAPI.Method, path: String? = nil, validResponseCodes: Range<Int> = 200..<300) {
        self.path = path
        self.method = method
        self.validResponseCodes = validResponseCodes
    }
}
