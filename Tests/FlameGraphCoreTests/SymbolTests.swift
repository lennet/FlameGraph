import FlameGraphCore
import class Foundation.Bundle
import XCTest

class SymbolTests: XCTestCase {
    func testExample() {
        let symbol = Symbol(weight: "71.00 ms 6.0%", selfWeight: "0 s", symbolName: "  -[UITabBarController initWithNibName:bundle:]")
        XCTAssertEqual(symbol.weight, "71.00ms")
        XCTAssertEqual(symbol.selfWeight, "0 s")
        XCTAssertEqual(symbol.percentage, 6)
        XCTAssertEqual(symbol.name, "-[UITabBarController initWithNibName:bundle:]")
        XCTAssertEqual(symbol.depthLevel, 2)
    }
}
