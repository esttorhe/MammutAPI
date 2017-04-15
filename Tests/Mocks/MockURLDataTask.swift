//
// Created by Esteban Torres on 15.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
@testable import Mammut

internal class MockURLDataTask: DataTask {
    var didCallResume = false

    func resume() {
        didCallResume = true
    }
}
