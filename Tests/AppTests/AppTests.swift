import XCTVapor

final class AppTests: AppXCTestCase {

    func testHelloWorld() throws {
        try app.test(.GET, "hello") { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hello, world!")
        }
    }
}
