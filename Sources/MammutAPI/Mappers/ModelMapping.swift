//
// Created by Esteban Torres on 16.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

extension MammutAPIError {
    public enum MappingError: Error, CustomStringConvertible {
        case incompleteModel
        case invalidJSON

        public var description: String {
            switch self {
                case .incompleteModel: return "JSON model was incomplete (required fields weren't present or empty)."
                case .invalidJSON: return "Returned data cannot be parsed into valid JSON"
            }
        }

        public static func ==(lhs: MappingError, rhs: MappingError) -> Bool {
            switch (lhs, rhs) {
                case (.incompleteModel, .incompleteModel): return true
                case (.invalidJSON, .invalidJSON): return true
                default: return false
            }
        }
    }
}

extension MammutAPIError.MappingError: CustomNSError {
    public static var errorDomain: String { return "es.estebantorr.MammutAPI.MappingError" }
    public var errorUserInfo: [String : Any] { return [ NSLocalizedDescriptionKey: description ] }

    public var errorCode: Int {
        switch self {
        case .incompleteModel: return -1
        case .invalidJSON: return -2
        }
    }
}

internal protocol ModelMapping {
    associatedtype Model
    typealias JSONDictionary = [String: Any]
    func map(data: Data) -> Result<Model, MammutAPIError.MappingError>
    func map(json: JSONDictionary) -> Result<Model, MammutAPIError.MappingError>
    func map(array: [JSONDictionary]) -> Result<[Model], MammutAPIError.MappingError>
}

extension ModelMapping {
    func map(data: Data) -> Result<Model, MammutAPIError.MappingError> {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let json = jsonObject as? JSONDictionary else {
            return .failure(MammutAPIError.MappingError.invalidJSON)
        }

        return map(json: json)
    }

    func map(array: [JSONDictionary]) -> Result<[Model], MammutAPIError.MappingError> {
        let mappedResult = array.flatMap{ map(json: $0) }.reduce(.success([])) {
            (result: Result<[Model], MammutAPIError.MappingError>, element: Result<Model, MammutAPIError.MappingError>) -> Result<[Model], MammutAPIError.MappingError> in
            if case var .success(array) = result,
                    case let .success(mappedModel) = element {
                array.append(mappedModel)
                return .success(array)
            }

            return result
        }
        return mappedResult
    }

}
