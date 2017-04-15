//
// Created by Esteban Torres on 10/04/2017.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal protocol DataTask {
    func resume()
}

extension URLSessionDataTask: DataTask {}

internal protocol DataTaskCreating {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Swift.Void
    func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> DataTask
}

extension URLSession: DataTaskCreating {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskCreating.CompletionHandler) -> DataTask {
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask) as DataTask
    }
}
