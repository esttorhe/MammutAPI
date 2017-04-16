//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal extension Endpoint {
    enum Timeline {
        static var timelinePath: String { return "timelines" }

        case home
        case local
        case tag(String)
    }
}

extension Endpoint.Timeline: URLProviding, Equatable {
    public static func ==(lhs: Endpoint.Timeline, rhs: Endpoint.Timeline) -> Bool {
        switch (lhs, rhs) {
            case (.home, .home): return true
            case (.local, .local): return true
            case let (.tag(lhsTag), .tag(rhsTag)): return lhsTag == rhsTag
            default: return false
        }
    }

    var method: Method { return .get }

    var path: String? {
        return "\(Endpoint.Timeline.timelinePath)/\(subPath)"
    }

    var validResponseCodes: Range<Int> {
        return 200..<300
    }
}

fileprivate extension Endpoint.Timeline {
    var subPath: String {
        switch self {
            case .home: return "home"
            case .local: return "public"
            case .tag(let tag): return "tag/\(tag)"
        }
    }
}
