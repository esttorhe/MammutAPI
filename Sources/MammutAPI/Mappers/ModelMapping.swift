//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

extension MammutAPIError {
    public enum MappingError: Error, CustomStringConvertible {
        case incompleteModel

        public var description: String {
            switch self {
                case .incompleteModel: return "JSON model was incomplete (required fields weren't present or empty)."
            }
        }

        public static func ==(lhs: MappingError, rhs: MappingError) -> Bool {
            switch (lhs, rhs) {
                case (.incompleteModel, .incompleteModel): return true
            }
        }
    }
}

extension MammutAPIError.MappingError: CustomNSError {
    public static var errorDomain: String { return "me.estebantorr.MammutAPI.MappingError" }
    public var errorUserInfo: [String : Any] { return [ NSLocalizedDescriptionKey: description ] }

    public var errorCode: Int {
        switch self {
        case .incompleteModel: return -1
        }
    }
}

extension NSError {
    convenience init(mappingError: MammutAPIError.MappingError) {
        self.init(
                domain: MammutAPIError.MappingError.errorDomain,
                code: mappingError.errorCode,
                userInfo: mappingError.errorUserInfo)
    }
}

internal protocol ModelMapping {
    func map<T>(data: Data) -> Result<T, MammutAPIError.MappingError>
}
