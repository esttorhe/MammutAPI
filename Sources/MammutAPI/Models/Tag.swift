//
// Created by Esteban Torres on 23.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public struct Tag {
    let name: String
    let url: URL
}

// MARK: - Equatable

extension Tag: Equatable {
    public static func ==(lhs: Tag, rhs: Tag) -> Bool {
        return (
                lhs.name == rhs.name &&
                lhs.url == rhs.url
        )
    }
}
