//
// Created by Esteban Torres on 23.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public struct Card {
    let url: URL
    let title: String
    let description: String
    let image: URL?
}

// MARK: - Equatable

extension Card: Equatable {
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.url == rhs.url
    }
}
