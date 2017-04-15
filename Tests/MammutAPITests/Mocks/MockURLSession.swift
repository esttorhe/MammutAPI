//
// Created by Esteban Torres on 10/04/2017.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
@testable import MammutAPI

internal class MockURLSession: DataTaskCreating {
    var didCallDataTask = false
    var dataTask: DataTask? = nil
    var completion: DataTaskCreating.CompletionHandler? = nil
    var dataTaskArgs: ((URLRequest, (Data?, URLResponse?, Error?) -> Void) -> Void)? = nil

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTask {
        dataTaskArgs?(request, completionHandler)
        completion = completionHandler
        didCallDataTask = true

        return dataTask ?? URLSessionDataTask()
    }
}
