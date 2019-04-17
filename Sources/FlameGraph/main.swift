import AppKit
import Foundation

let content: String

if CommandLine.arguments.count == 3 {
    do {
        content = try String(contentsOfFile: CommandLine.arguments[1])
    } catch {
        fatalError("Loading content from \(CommandLine.arguments[1]) failed")
    }
} else if CommandLine.arguments.count == 2,
    let pasteBoardString = NSPasteboard.general.string(forType: .string) {
    content = pasteBoardString
} else {
    fatalError("The tool takes 2 arguments, an input and an output path or only an output path if the input is in the Pasteboard")
}

guard let callGraph = TraceParser.parse(content: content) else {
    fatalError("Parsing failed")
}

let image = ImageRenderer.render(graph: callGraph)

do {
    try image.write(to: URL(fileURLWithPath: CommandLine.arguments.last!))
} catch {
    fatalError("Saving to \(CommandLine.arguments.last!) failed")
}
