import XCTest
@testable import BookViewKit

final class BookViewKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BookViewKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
