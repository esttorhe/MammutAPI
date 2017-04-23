//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public struct Status {
    let id: Int
    let createdAt: Date
    let inReplyToId: String?
    let inReplyToAccountId: String?
    let sensitive: Bool
    let spoilerText: String?
    let visibility: StatusVisibility
    let application: Application?
    let account: Account
    let mediaAttachments: [Attachment]
    let mentions: [Mention]
    let tags: [String]
    let uri: String
    let content: String
    let url: URL
    let reblogsCount: Int
    let favouritesCount: Int
//  let reblog: Status?
    let favourited: Bool
    let reblogged: Bool
}

// MARK: - Equatable

extension Status: Equatable {
    public static func ==(lhs: Status, rhs: Status) -> Bool {
        return (
                lhs.id == rhs.id &&
                lhs.url == rhs.url &&
                lhs.visibility == rhs.visibility &&
                lhs.account == rhs.account &&
                lhs.content == rhs.content &&
                lhs.uri == rhs.uri &&
                lhs.createdAt == rhs.createdAt
        )
    }
}