import Foundation

public protocol Renderer {
    associatedtype T: RenderTarget
    static func render(graph: CallGraphNode) -> T
}

public protocol RenderTarget {
    func write(to url: URL) throws
}
