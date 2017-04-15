import Foundation
import XCTest

// XCTestCaseProvider is defined on Linux as part of swift-corelibs-xctest,
// but is not available on OS X. By defining this protocol and extension
// we ensure that the tests fail on OS X if they haven't been configured properly
// to be run on Linux
#if !os(Linux)

protocol XCTestCaseProvider {
  var allTests : [(String, () throws -> Void)] { get }
}

extension XCTestCase {
  override open func tearDown() {
    if let provider = self as? XCTestCaseProvider {
      provider.assertContainsTest(name: invocation!.selector.description)
    }

    super.tearDown()
  }
}

extension XCTestCaseProvider {
  fileprivate func assertContainsTest(name: String) {
    let contains = self.allTests.contains(where:{ test in
      return test.0 == name
    })

    XCTAssert(contains, "Test '\(name)' is missing from the allTests array")
  }
}

#endif
