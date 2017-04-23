//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public class Status {
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
    let tags: [Tag]
    let uri: String
    let content: String
    let url: URL
    let reblogsCount: Int
    let favouritesCount: Int
    let reblog: Status?
    let favourited: Bool
    let reblogged: Bool

    init(
            id: Int,
            createdAt: Date,
            inReplyToId: String?,
            inReplyToAccountId: String?,
            sensitive: Bool,
            spoilerText: String?,
            visibility: StatusVisibility,
            application: Application?,
            account: Account,
            mediaAttachments: [Attachment],
            mentions: [Mention],
            tags: [Tag],
            uri: String,
            content: String,
            url: URL,
            reblogsCount: Int,
            favouritesCount: Int,
            reblog: Status?,
            favourited: Bool,
            reblogged: Bool
    ) {
        self.id = id
        self.createdAt = createdAt
        self.inReplyToId = inReplyToId
        self.inReplyToAccountId = inReplyToAccountId
        self.sensitive = sensitive
        self.spoilerText = spoilerText
        self.visibility = visibility
        self.application = application
        self.account = account
        self.mediaAttachments = mediaAttachments
        self.mentions = mentions
        self.tags = tags
        self.uri = uri
        self.content = content
        self.url = url
        self.reblogsCount = reblogsCount
        self.favouritesCount = favouritesCount
        self.reblog = reblog
        self.favourited = favourited
        self.reblogged = reblogged
    }
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