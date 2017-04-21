//
// Created by Esteban Torres on 21.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal class AttachmentMapper: ModelMapping {
    typealias Model = Attachment

    func map(json: ModelMapping.JSONDictionary) -> Result<Attachment, MammutAPIError.MappingError> {
        guard
                let id = json["id"] as? Int,
                let typeString = json["type"] as? String,
                let type = Attachment.MediaType(rawValue: typeString),
                let urlString = json["url"] as? String,
                let url = URL(string: urlString),
                let previewURLString = json["preview_url"] as? String,
                let previewURL = URL(string: previewURLString)
                else {
            return .failure(MammutAPIError.MappingError.incompleteModel)
        }

        var remoteURL: URL? = nil
        if let remoteURLString = json["remote_url"] as? String,
           let url = URL(string: remoteURLString) {
            remoteURL = url
        }

        var textURL: URL? = nil
        if let textURLString = json["text_url"] as? String,
                let url = URL(string: textURLString) {
            textURL = url
        }

        let attachment = Attachment(
                id: id,
                type: type,
                url: url,
                remoteURL: remoteURL,
                previewURL: previewURL,
                textURL: textURL
        )
        return .success(attachment)
    }
}
