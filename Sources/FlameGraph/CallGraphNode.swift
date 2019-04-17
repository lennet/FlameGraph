import Foundation

class CallGraphNode {
    var symbol: Symbol
    var subNodes: [CallGraphNode] = []
    var parentNode: CallGraphNode?

    init(symbol: Symbol) {
        self.symbol = symbol
    }
}

extension CallGraphNode {
    var maxDepth: Int {
        var result = symbol.depthLevel
        for node in subNodes {
            result = max(node.maxDepth, result)
        }
        return result
    }
}
