//
// Created by Esteban Torres on 09/04/2017.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

public enum MammutError {

    public enum NetworkErrors: Error, CustomStringConvertible {
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