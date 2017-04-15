//
// Created by Esteban Torres on 14.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import XCTest
import Foundation
@testable import MammutAPI

class EndpointRequestTests: XCTestCase {
    var basePath: String!
    var session: MockURLSession!
    var endpoint: MockEndpoint!
    var task: MockURLDataTask!
    let emptyHandler: EndpointRequesting.CompletionHandler = { _ in }

    override func setUp() {
        super.setUp()

        basePath = "www.example.com"
        session = MockURLSession()
        endpoint = MockEndpoint(method: .get)
        task = MockURLDataTask()
    }

    func test_execute_passesDataTaskCallToSession() {
        let subject = self.makeSubject(includeTaskOnSession: true)
        subject.execute(emptyHandler)
        XCTAssertTrue(session.didCallDataTask)
    }

    func test_execute_setsCompletionHandlerOnDataTask() {
        let subject = self.makeSubject(includeTaskOnSession: true)
        XCTAssertNil(session.completion)
        subject.execute(emptyHandler)
        XCTAssertNotNil(session.completion)
    }

    func test_execute_sendsCorrectURLToDataTaskCreation_noPath() {
        let expectation = self.expectation(description: "Sending correct URL")
        let subject = self.makeSubject(includeTaskOnSession: true)
        let expectedURL = URL(string: self.basePath)

        session.dataTaskArgs = { request, _ in
            XCTAssertEqual(expectedURL, request.url)
            expectation.fulfill()
        }

        subject.execute(emptyHandler)

        self.waitForExpectations(timeout: 2)
    }

    func test_execute_sendsCorrectURLToDataTaskCreation_withPath() {
        let extraPath = "extraPath"
        endpoint = MockEndpoint(method: .get, path: extraPath)
        let expectation = self.expectation(description: "Sending correct URL")
        let subject = self.makeSubject(includeTaskOnSession: true)
        let expectedURL = URL(string: self.basePath)?.appendingPathComponent(extraPath)

        session.dataTaskArgs = { request, _ in
            XCTAssertEqual(expectedURL, request.url)
            expectation.fulfill()
        }

        subject.execute(emptyHandler)

        self.waitForExpectations(timeout: 2)
    }

    func test_execute_callsCompletionHandler() {
        let expectation = self.expectation(description: "execute calls completion handler")
        let subject = makeSubject()

        session.dataTask = task
        session.dataTaskArgs = { _, completion in
            completion(nil, nil, nil)
        }

        subject.execute { result in
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 2)
    }

    func test_execute_malformedURLCalls_completionHandlerWithMalformedURLError() {
        let expectation = self.expectation(description: "execute calls completion handler")
        let task = MockURLDataTask()
        session.dataTask = task
        basePath = "I am not a valid url"

        let subject = makeSubject()
        subject.execute { result in

            switch result {
            case .success: XCTFail("Should have returned malformed error")
            case .failure(let error):
                XCTAssertEqual(error, MammutError.NetworkErrors.malformedURL)
            }

            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 2)
    }

    func test_execute_callsCompletionHandlerWithData_success() {
        let expectation = self.expectation(description: "execute success calls completion handler")
        let task = MockURLDataTask()
        let subject = makeSubject()
        let data = Data()
        let response = URLResponse(url: URL(string: "www.example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)

        session.dataTask = task
        session.dataTaskArgs = { _, completion in
            completion(data, response, nil)
        }

        subject.execute { result in
            switch result {
            case .failure(let error): XCTFail("Should have succeeded. Received error: \(error)")
            case .success(let resultData): XCTAssertEqual(data, resultData)
            }

            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 2)
    }

    func test_execute_callsCompletionHandleResponseNoData_failure() {
        let expectation = self.expectation(description: "execute success calls completion handler")
        let task = MockURLDataTask()
        let response = URLResponse(url: URL(string: "www.example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let subject = makeSubject()

        session.dataTask = task
        session.dataTaskArgs = { _, completion in
            completion(nil, response, nil)
        }

        subject.execute { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, MammutError.NetworkErrors.emptyResponse)
            case .success: XCTFail("Should have return empty response")
            }

            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 2)
    }

    func test_execute_callsCompletionHandleNoResponse_failure() {
        let expectation = self.expectation(description: "execute success calls completion handler")
        let task = MockURLDataTask()
        let subject = makeSubject()

        session.dataTask = task
        session.dataTaskArgs = { _, completion in
            completion(Data(), nil, nil)
        }

        subject.execute { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, MammutError.NetworkErrors.emptyResponse)
            case .success: XCTFail("Should have return empty response")
            }

            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 2)
    }

    func test_execute_callsCompletionHandle_failure() {
        let expectation = self.expectation(description: "execute success calls completion handler")
        let task = MockURLDataTask()
        let subject = makeSubject()
        let data = Data()
        let response = URLResponse(url: URL(string: "www.example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let serverError = MockError.testError

        session.dataTask = task
        session.dataTaskArgs = { _, completion in
            completion(data, response, serverError)
        }

        subject.execute { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, MammutError.NetworkErrors.serverError(serverError))
            case .success: XCTFail("Should have return a server error")
            }

            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 2)
    }

    func test_execute_callsCompletionHandle_responseWithInvalidStatusCode_failure() {
        let expectation = self.expectation(description: "execute success calls completion handler")
        let task = MockURLDataTask()
        let subject = makeSubject()
        let data = Data()
        let response = HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 999, httpVersion: nil, headerFields: nil)

        session.dataTask = task
        session.dataTaskArgs = { _, completion in
            completion(data, response, nil)
        }

        subject.execute { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, MammutError.NetworkErrors.invalidStatusCode(response))
            case .success: XCTFail("Should have return a server error")
            }

            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 2)
    }
}

// MARK: Linux Support

extension EndpointRequestTests {
    static var allTests: [(String, (EndpointRequestTests) -> () throws -> Void)] {
        return [
                ("test_execute_passesDataTaskCallToSession", test_execute_passesDataTaskCallToSession),
                ("test_execute_setsCompletionHandlerOnDataTask", test_execute_setsCompletionHandlerOnDataTask),
                ("test_execute_malformedURLCalls_completionHandlerWithMalformedURLError", test_execute_malformedURLCalls_completionHandlerWithMalformedURLError),
                ("test_execute_callsCompletionHandler", test_execute_callsCompletionHandler),
                ("test_execute_callsCompletionHandlerWithData_success", test_execute_callsCompletionHandlerWithData_success),
                ("test_execute_callsCompletionHandle_failure", test_execute_callsCompletionHandle_failure),
                ("test_execute_sendsCorrectURLToDataTaskCreation_noPath", test_execute_sendsCorrectURLToDataTaskCreation_noPath),
                ("test_execute_sendsCorrectURLToDataTaskCreation_withPath", test_execute_sendsCorrectURLToDataTaskCreation_withPath),
                ("test_execute_callsCompletionHandler", test_execute_callsCompletionHandler),
                ("test_execute_callsCompletionHandleResponseNoData_failure", test_execute_callsCompletionHandleResponseNoData_failure),
                ("test_execute_callsCompletionHandleNoResponse_failure", test_execute_callsCompletionHandleNoResponse_failure),
                ("test_execute_callsCompletionHandle_responseWithInvalidStatusCode_failure", test_execute_callsCompletionHandle_responseWithInvalidStatusCode_failure)
        ]
    }
}

// MARK: - Helper test methods

fileprivate extension EndpointRequestTests {
    func makeSubject(includeTaskOnSession: Bool = false) -> EndpointRequest {
        if includeTaskOnSession == true {
            session.dataTask = task
        }

        return EndpointRequest(
                basePath: basePath,
                session: session,
                endpoint: endpoint
        )
    }
}
