//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal class AccountMapper: ModelMapping {
    typealias Model = Account
    func map(data: Data) -> Result<Model, MammutAPIError.MappingError> {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let json = jsonObject as? JSONDictionary else {
            return .failure(MammutAPIError.MappingError.invalidJSON)
        }

        guard
                let id = json["id"] as? Int,
                let username = json["username"] as? String,
                let acct = json["acct"] as? String,
                let displayName = json["display_name"] as? String,
                let locked = json["locked"] as? Bool,
                let createdAtString = json["created_at"] as? String,
                let createdAt = Date(from: createdAtString),
                let note = json["note"] as? String,
                let url = json["url"] as? String,
                let avatar = json["avatar"] as? String,
                let avatarStatic = json["avatar_static"] as? String,
                let header = json["header"] as? String,
                let headerStatic = json["header_static"] as? String,
                let followersCount = json["followers_count"] as? Int,
                let followingCount = json["following_count"] as? Int,
                let statusesCount = json["statuses_count"] as? Int
                else {
            return .failure(MammutAPIError.MappingError.incompleteModel)
        }

        let account = Account(
                id: id,
                username: username,
                acct: acct,
                displayName: displayName,
                locked: locked,
                createdAt: createdAt,
                followersCount: followersCount,
                followingCount: followingCount,
                statusesCount: statusesCount,
                note: note,
                url: url,
                avatar: avatar,
                avatarStatic: avatarStatic,
                header: header,
                headerStatic: headerStatic
        )

        return .success(account)
    }
}
