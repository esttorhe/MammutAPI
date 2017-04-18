//
// Created by Esteban Torres on 18.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal class ApplicationMapper: ModelMapping {
    typealias Model = Application
    func map(data: Data) -> Result<Model, MammutAPIError.MappingError> {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let json = jsonObject as? JSONDictionary else {
            return .failure(MammutAPIError.MappingError.invalidJSON)
        }

        return map(json: json)
    }

    func map(json: ModelMapping.JSONDictionary) -> Result<Model, MammutAPIError.MappingError> {
        guard let name = json["name"] as? String else {
            return .failure(MammutAPIError.MappingError.incompleteModel)
        }

        let website = json["website"] as? String
        let application = Application(name: name, website: website)

        return .success(application)
    }
}
