//
// Created by Esteban Torres on 23.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal class TagMapper: ModelMapping {
    typealias Model = Tag

    func map(json: ModelMapping.JSONDictionary) -> Result<Model, MammutAPIError.MappingError> {
        guard
                let name = json["name"] as? String,
                let urlString = json["url"] as? String,
                let url = URL(string: urlString)
                else {
            return .failure(MammutAPIError.MappingError.incompleteModel)
        }

        let mention = Tag(
                name: name,
                url: url
        )
        return .success(mention)
    }
}
