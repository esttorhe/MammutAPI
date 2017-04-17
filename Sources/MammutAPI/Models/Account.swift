//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public struct Account {
    let id: Int
    let username: String
    let acct: String
    let displayName: String
    let locked: Bool
    let createdAt: Date
    let followersCount: Int
    let followingCount: Int
    let statusesCount: Int
    let note: String
    let url: String
    let avatar: String
    let avatarStatic: String
    let header: String
    let headerStatic: String

    init(
            id: Int,
            username: String,
            acct: String,
            displayName: String,
            locked: Bool,
            createdAt: Date,
            followersCount: Int,
            followingCount: Int,
            statusesCount: Int,
            note: String,
            url: String,
            avatar: String,
            avatarStatic: String,
            header: String,
            headerStatic: String) {
        self.id = id
        self.username = username
        self.acct = acct
        self.displayName = displayName
        self.locked = locked
        self.createdAt = createdAt
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.statusesCount = statusesCount
        self.note = note
        self.url = url
        self.avatar = avatar
        self.avatarStatic = avatarStatic
        self.header = header
        self.headerStatic = headerStatic
    }
}