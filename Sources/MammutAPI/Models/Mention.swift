//
// Created by Esteban Torres on 21.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public struct Mention {
    let id: Int
    let url: URL
    let username: String
    let acct: String
}

// MARK: - Equatable

extension Mention: Equatable {
    public static func ==(lhs: Mention, rhs: Mention) -> Bool {
        return (
                lhs.id == rhs.id &&
                lhs.url == rhs.url &&
                lhs.username == rhs.username &&
                lhs.acct == rhs.acct
        )
    }
}