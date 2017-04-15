//
// Created by Esteban Torres on 09/04/2017.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public class Application {
    let name: String
    let website: String?
    let redirectURI: String
    let identifier: Int
    let clientId: String
    let clientSecret: String

    init
    (
            name: String,
            website: String? = nil,
            redirectURI: String,
            identifier: Int,
            clientId: String,
            clientSecret: String
    ) {
        self.name = name
        self.website = website
        self.redirectURI = redirectURI
        self.identifier = identifier
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
}