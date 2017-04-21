//
// Created by Esteban Torres on 21.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public struct Attachment {

    public enum MediaType: String {
        case image
        case video
        case gifv
    }

    let id: Int
    let type: Attachment.MediaType
    let url: URL
    let remoteURL: URL?
    let previewURL: URL
    let textURL: URL?
}

// MARK: - Equatable

extension Attachment: Equatable {
    public static func ==(lhs: Attachment, rhs: Attachment) -> Bool {
        return (
                lhs.id == rhs.id &&
                lhs.url == rhs.url &&
                lhs.type == rhs.type &&
                lhs.remoteURL == rhs.remoteURL
        )
    }
}