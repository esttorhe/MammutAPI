//
// Created by Esteban Torres on 09/04/2017.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public struct Application {
    let name: String
    let website: String?
}

// MARK: - Equatable

extension Application: Equatable {
    public static func ==(lhs: Application, rhs: Application) -> Bool {
        return (
                lhs.name == rhs.name &&
                lhs.website == rhs.website
        )
    }
}