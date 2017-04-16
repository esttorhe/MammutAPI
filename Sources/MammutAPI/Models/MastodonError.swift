//
// Created by Esteban Torres on 09/04/2017.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public enum MammutError {
    public enum NetworkErrors: Error, CustomStringConvertible, Equatable {
        case emptyResponse
        case serverError(/*MastodonError*/Error)
        case invalidStatusCode(URLResponse?)
        case invalidJSON
        case malformedURL

        public var description: String {
            switch self {
            case .emptyResponse: return "Empty response from the server (no data)"
            case .serverError(let error): return "Server returned an error: \(error)"
            case .invalidStatusCode: return "Server replied with an invalid/unexpected status code"
            case .invalidJSON: return "Returned data cannot be parsed into valid JSON"
            case .malformedURL: return "Provided URL is malformed or invalid"
            }
        }

        public static func ==(lhs: NetworkErrors, rhs: NetworkErrors) -> Bool {
            switch (lhs, rhs) {
                case (.emptyResponse, .emptyResponse): return true
                case (.invalidJSON, .invalidJSON): return true
                case (.malformedURL, .malformedURL): return true
                case (.serverError(let lhsError), .serverError(let rhsError)): return (lhsError as! NSError) == (rhsError as! NSError)
                case (.invalidStatusCode(let lhsResponse), .invalidStatusCode(let rhsResponse)):
                    let lhsStatusCode = (lhsResponse as? HTTPURLResponse)?.statusCode ?? Int.min
                    let rhsStatusCode = (rhsResponse as? HTTPURLResponse)?.statusCode ?? Int.min
                    let lhsURL = lhsResponse?.url
                    let rhsURL = rhsResponse?.url

                    return (lhsStatusCode == rhsStatusCode) &&
                            (lhsURL == rhsURL)

                default: return false
            }
        }
    }
}

extension MammutError.NetworkErrors: CustomNSError {
    public static var errorDomain: String { return "me.estebantorr.MammutAPI.NetworkError" }
    public var errorUserInfo: [String : Any] { return [ NSLocalizedDescriptionKey: description ] }

    public var errorCode: Int {
        switch self {
        case .emptyResponse: return -1
        case .serverError: return -2
        case .invalidStatusCode: return -3
        case .invalidJSON: return -4
        case .malformedURL: return -5
        }
    }
}

public class MastodonError: Error {

}