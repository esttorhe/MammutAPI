//
// Created by Esteban Torres on 23.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal class CardMapper: ModelMapping {
    typealias Model = Card

    func map(json: ModelMapping.JSONDictionary) -> Result<Card, MammutAPIError.MappingError> {
        guard
                let urlString = json["url"] as? String,
                let url = URL(string: urlString),
                let title = json["title"] as? String,
                let description = json["description"] as? String
                else {
            return .failure(MammutAPIError.MappingError.incompleteModel)
        }

        var image: URL? = nil
        if let imageString = json["image"] as? String,
           let imageURL = URL(string: imageString) {
            image = imageURL
        }

        let card = Card(
                url: url,
                title: title,
                description: description,
                image: image
        )
        return .success(card)
    }
}
