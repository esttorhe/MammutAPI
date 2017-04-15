//
// Created by Esteban Torres on 14.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal enum Method: String  {
    case get
    case post
    case put
    case delete
}

internal protocol URLProviding {
    var method: Method { get }
    var path: String? { get }
    var validResponseCodes: Range<Int> { get }
}

internal enum Endpoint {
    case registerApp
}

extension Endpoint: URLProviding {
    var method: Method {
        switch self {
            case .registerApp: return .post
            default: return .get
        }
    }

    var path: String? {
        return internalPath
    }

    var validResponseCodes: Range<Int> {
        switch self {
            default: return 200..<300
        }
    }

    var internalPath: String? {
        switch self {
        case .registerApp: return "apps"
        }
    }
}
