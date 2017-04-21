//
// Created by Esteban Torres on 21.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation
import XCTest
@testable import MammutAPI

public class AttachmentTests: XCTestCase {
    func test_sameAttachments_equal() {
        let subject1 = AttachmentTests.makeAttachment()
        let subject2 = AttachmentTests.makeAttachment()
        XCTAssertEqual(subject1, subject2)
    }

    func test_differentAttachments_notEqual() {
        let subject1 = AttachmentTests.makeAttachment(id: #line)
        let subject2 = AttachmentTests.makeAttachment(id: #line)
        XCTAssertNotEqual(subject1, subject2)
    }
}

// MARK: - Linux Support

extension AttachmentTests {
    static var allTests: [(String, (AttachmentTests) -> () throws -> Void)] {
        return [
                ("test_sameAttachments_equal", test_sameAttachments_equal),
                ("test_differentAttachments_notEqual", test_differentAttachments_notEqual)
        ]
    }
}

// MARK: Test Helpers

fileprivate extension AttachmentTests {
    static func makeAttachment(id: Int = Int.max) -> Attachment {
        return Attachment(
                id: id,
                type: .image,
                url: URL(string: "www.example.com")!,
                remoteURL: nil,
                previewURL: URL(string: "www.example.com")!,
                textURL: nil
        )
    }
}
