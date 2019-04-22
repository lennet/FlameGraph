import FlameGraphCore
import class Foundation.Bundle
import XCTest

class TraceParserTests: XCTestCase {
    func testParseSymbolsFromFile() {
        let inputURL = productsDirectory.appendingPathComponent("/../../../example/input")
        let string = try! String(contentsOfFile: inputURL.path)
        let symbols: [Symbol] = TraceParser.parse(content: string)
        let expectedNumberOfSymbols = string.split(separator: Character("\n")).count - 1
        XCTAssertEqual(symbols.count, expectedNumberOfSymbols)
    }

    func testParseSymbolsFromString() {
        let input = """
        Weight\tSelf Weight \t \tSymbol Name
        92.00 ms    7.8%\t0 s\t \t-[UIApplication _handleDelegateCallbacksWithOptions:isSuspended:restoreState:]
        92.00 ms    7.8%\t0 s\t \t -[AppDelegate application:didFinishLaunchingWithOptions:]
        71.00 ms    6.0%\t0 s\t \t  -[UITabBarController initWithNibName:bundle:]
        """
        let symbols: [Symbol] = TraceParser.parse(content: input)
        XCTAssertEqual(symbols.count, 3)
        XCTAssertEqual(symbols[0], Symbol(weight: "92.00 ms    7.8%", selfWeight: "0 s", symbolName: "-[UIApplication _handleDelegateCallbacksWithOptions:isSuspended:restoreState:]"))
        XCTAssertEqual(symbols[1], Symbol(weight: "92.00 ms    7.8%", selfWeight: "0 s", symbolName: " -[AppDelegate application:didFinishLaunchingWithOptions:]"))
        XCTAssertEqual(symbols[2], Symbol(weight: "71.00 ms    6.0%", selfWeight: "0 s", symbolName: "  -[UITabBarController initWithNibName:bundle:]"))
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
        #if os(macOS)
            for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
                return bundle.bundleURL.deletingLastPathComponent()
            }
            fatalError("couldn't find the products directory")
        #else
            return Bundle.main.bundleURL
        #endif
    }
}
