//
// Created by Esteban Torres on 17.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal class StatusMapper: ModelMapping {
    typealias Model = Status

    func map(data: Data) -> Result<Model, MammutAPIError.MappingError> {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let json = jsonObject as? JSONDictionary else {
            return .failure(MammutAPIError.MappingError.invalidJSON)
        }

        return map(json: json)
    }

    func map(json: ModelMapping.JSONDictionary) -> Result<Model, MammutAPIError.MappingError> {
        let accountMapper = AccountMapper()
        let applicationMapper = ApplicationMapper()
        guard
                let id = json["id"] as? Int,
                let createdAtString = json["created_at"] as? String,
                let createdAt = Date(from: createdAtString),
                let sensitive = json["sensitive"] as? Bool,
                let visibilityText = json["visibility"] as? String,
                let visibility = StatusVisibility(rawValue: visibilityText),
                let accountDict = json["account"] as? [String: Any],
                let account = accountMapper.map(json: accountDict).value,
                let mediaAttachments = json["media_attachments"] as? [String],
                let mentions = json["mentions"] as? [String],
                let tags = json["tags"] as? [String],
                let uri = json["uri"] as? String,
                let content = json["content"] as? String,
                let urlString = json["url"] as? String,
                let url = URL(string: urlString),
                let reblogsCount = json["reblogs_count"] as? Int,
                let favouritesCount = json["favourites_count"] as? Int
                else {
            return .failure(MammutAPIError.MappingError.incompleteModel)
        }

        let inReplyToId = json["in_reply_to_id"] as? String
        let inReplyToAccountId = json["in_reply_to_account_id"] as? String
        let spoilerText = json["spoiler_test"] as? String
        var application: Application? = nil
        if let applicationDict = json["application"] as? JSONDictionary,
           case let .success(app) = applicationMapper.map(json: applicationDict) {
            application = app
        }

        let favourited = (json["favourited"] as? Bool) ?? false
        let reblogged = (json["reblogged"] as? Bool) ?? false

        let status = Status(
                id: id,
                createdAt: createdAt,
                inReplyToId: inReplyToId,
                inReplyToAccountId: inReplyToAccountId,
                sensitive: sensitive,
                spoilerText: spoilerText,
                visibility: visibility,
                application: application,
                account: account,
                mediaAttachments: mediaAttachments,
                mentions: mentions,
                tags: tags,
                uri: uri,
                content: content,
                url: url,
                reblogsCount: reblogsCount,
                favouritesCount: favouritesCount,
                favourited: favourited,
                reblogged: reblogged
        )

        return .success(status)
    }

}
