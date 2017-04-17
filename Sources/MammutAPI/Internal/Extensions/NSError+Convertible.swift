//
// Created by Esteban Torres on 17.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal extension NSError {
    convenience init(error: CustomNSError) {
        self.init(
                domain: type(of: error).errorDomain,
                code: error.errorCode,
                userInfo: error.errorUserInfo
        )
    }

    convenience init(error: Error) {
        if let error = error as? CustomNSError {
            self.init(error: error)
        } else {
            let domain = "es.estebantorr.MammutAPI.Core"
            let code = Int.max
            let description = "Received an «Error» that cannot be casted to «NSError»: \(error)"

            self.init(
                    domain: domain,
                    code: code,
                    userInfo: [ NSLocalizedDescriptionKey: description ]
            )
        }
    }
}