//
// Created by Esteban Torres on 14.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal protocol EndpointRequesting {
    typealias CompletionHandler = (Result<Data, NSError>) -> Void
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
                    completion(.failure(MammutError.NetworkErrors.serverError(error) as NSError))
                    return
                }

                // Server replied with an empty response 🤔
                if response == nil {
                    completion(.failure(MammutError.NetworkErrors.emptyResponse as NSError))
                    return
                }

                // Status Code out of expected range
                if let response = response as? HTTPURLResponse,
                   !self.endpoint.validResponseCodes.contains(response.statusCode) {
                    completion(.failure(MammutError.NetworkErrors.invalidStatusCode(response: response) as NSError))
                    return
                }

                // No data returned
                guard let data = data else {
                    completion(.failure(MammutError.NetworkErrors.emptyResponse as NSError))
                    return
                }

                completion(.success(data))
            }

            task.resume()
        }
    }
}

fileprivate extension EndpointRequest {
    func resolveEndpoint() -> Result<URLRequest, NSError> {
        guard let baseURL = URL(string: basePath) else {
            return .failure(MammutError.NetworkErrors.malformedURL as NSError)
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
