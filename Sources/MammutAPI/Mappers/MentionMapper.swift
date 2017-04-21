//
// Created by Esteban Torres on 21.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal class MentionMapper: ModelMapping {
    typealias Model = Mention

    func map(json: ModelMapping.JSONDictionary) -> Result<Mention, MammutAPIError.MappingError> {
        return nil
    }

}
