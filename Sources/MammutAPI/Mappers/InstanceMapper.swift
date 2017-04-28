//
// Created by Esteban Torres on 28.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal class InstanceMapper: ModelMapping {
    typealias Model = Instance

    func map(json: ModelMapping.JSONDictionary) -> Result<Model, MammutAPIError.MappingError> {
        guard
                let uri = json["uri"] as? String,
                let title = json["title"] as? String,
                let description = json["description"] as? String,
                let email = json["email"] as? String,
                let version = json["version"] as? String
                else {
            return .failure(MammutAPIError.MappingError.incompleteModel)
        }

        let instance = Instance(
                uri: uri,
                title: title,
                description: description,
                email: email,
                version: version
        )
        return .success(instance)
    }
}
