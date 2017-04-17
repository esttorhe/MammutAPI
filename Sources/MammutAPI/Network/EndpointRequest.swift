//
// Created by Esteban Torres on 14.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal protocol EndpointRequesting {
    typealias CompletionHandler = (Result<Data, MammutAPIError.NetworkError>) -> Void
    var basePath: String { get }
    func execute(_ completion: @escaping CompletionHandler)
}

internal class EndpointRequest: EndpointRequesting {
    let basePath: String
    let session: DataTaskCreating
    let endpoint: URLProviding

    init(basePath: String, session: DataTaskCreating, endpoint: URLProviding) {
        self.basePath = basePath
        self.session = session
        self.endpoint = endpoint
    }

    func execute(_ completion: @escaping EndpointRequesting.CompletionHandler) {
        let result = resolveEndpoint()

        switch result {
        case .failure(let error): completion(Result.failure(error))
        case .success(let urlRequest):
            let task = session.dataTask(with: urlRequest) { data, response, error in
                // Server returned an error
                if let error = error {
#if os(Linux)
                    // Had to add this because on Linux the build fails unless when casting Error to NSError
                    // unless forced casting it
                    if let error = error as? NSError {
                        completion(.failure(MammutAPIError.NetworkError.serverError(error)))
                    } else {
                        let underlyingError = NSError(error: error)
                        completion(.failure(MammutAPIError.NetworkError.serverError(underlyingError)))
                    }
#else
                    completion(.failure(MammutAPIError.NetworkError.serverError(error as NSError)))
#endif

                    return
                }

                // Server replied with an empty response 🤔
                if response == nil {
                    completion(.failure(MammutAPIError.NetworkError.emptyResponse))
                    return
                }

                // Status Code out of expected range
                if let response = response as? HTTPURLResponse,
                   !self.endpoint.validResponseCodes.contains(response.statusCode) {
                    completion(.failure(MammutAPIError.NetworkError.invalidStatusCode(response)))
                    return
                }

                // No data returned
                guard let data = data else {
                    completion(.failure(MammutAPIError.NetworkError.emptyResponse))
                    return
                }

                completion(.success(data))
            }

            task.resume()
        }
    }
}

fileprivate extension EndpointRequest {
    func resolveEndpoint() -> Result<URLRequest, MammutAPIError.NetworkError> {
        guard let baseURL = URL(string: basePath) else {
            return .failure(MammutAPIError.NetworkError.malformedURL)
        }

        let url: URL
        if let path = endpoint.path {
            url = baseURL.appendingPathComponent(path)
        } else {
            url = baseURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        return .success(request)
    }
}
