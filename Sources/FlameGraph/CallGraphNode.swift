import Foundation

class CallGraphNode {
    var symbol: Symbol
    var subNodes: [CallGraphNode] = []
    var parentNode: CallGraphNode?

    init(symbol: Symbol) {
        self.symbol = symbol
    }
}
