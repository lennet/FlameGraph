import Foundation

guard CommandLine.arguments.count == 3 else {
    fatalError("The tool takes 2 arguments, an input and an output path")
}

let content: String

do {
    content = try String(contentsOfFile: CommandLine.arguments[1])
} catch {
    fatalError("Loading content from \(CommandLine.arguments[1]) failed")
}

let callGraph = TraceParser.parse(content: content)
let image = ImageRenderer.render(graph: callGraph)

do {
    try image.write(to: URL(fileURLWithPath: CommandLine.arguments[2]))
} catch {
    fatalError("Saving to \(CommandLine.arguments[2]) failed")
}
