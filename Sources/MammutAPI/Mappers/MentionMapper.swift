//
// Created by Esteban Torres on 21.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal class MentionMapper: ModelMapping {
    typealias Model = Mention

    func map(json: ModelMapping.JSONDictionary) -> Result<Model, MammutAPIError.MappingError> {
        guard
                let id = json["id"] as? Int,
                let urlString = json["url"] as? String,
                let url = URL(string: urlString),
                let username = json["username"] as? String,
                let acct = json["acct"] as? String
                else {
            return .failure(MammutAPIError.MappingError.incompleteModel)
        }

        let mention = Mention(
                id: id,
                url: url,
                username: username,
                acct: acct
        )
        return .success(mention)
    }
}
