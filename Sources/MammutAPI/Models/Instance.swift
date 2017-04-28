//
// Created by Esteban Torres on 24.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public struct Instance {
    let uri: String
    let title: String
    let description: String
    let email: String
}

// MARK: - Equatable

extension Instance: Equatable {
    public static func ==(lhs: Instance, rhs: Instance) -> Bool {
        return (
                lhs.uri == rhs.uri &&
                lhs.title == rhs.title &&
                lhs.email == rhs.email
        )
    }
}
