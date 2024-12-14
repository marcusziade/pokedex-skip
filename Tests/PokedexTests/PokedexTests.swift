import XCTest
import OSLog
import Foundation
@testable import Pokedex

let logger: Logger = Logger(subsystem: "Pokedex", category: "Tests")

@available(macOS 13, *)
final class PokedexTests: XCTestCase {

    func testPokedex() throws {
        logger.log("running testPokedex")
        XCTAssertEqual(1 + 2, 3, "basic test")
    }

    func testDecodeType() throws {
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("Pokedex", testData.testModuleName)
    }

}

struct TestData : Codable, Hashable {
    var testModuleName: String
}
