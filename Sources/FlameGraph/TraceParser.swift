import Foundation

class TraceParser {
    class func parse(content: String) -> CallGraphNode? {
        let lines = content.split(separator: Character("\n")).dropFirst()
        let components: [[Substring]] = lines.compactMap {
            let components = $0.split(separator: Character("\t"))
            guard components.count == 4 else {
                return nil
            }
            return components
        }

        let symbols = components.map {
            Symbol(weight: String($0[0]), selfWeight: String($0[1]), symbolName: String($0[3]))
        }

        guard let firstSymbol = symbols.first else {
            return nil
        }
        let tree = CallGraphNode(symbol: firstSymbol)
        var lastKnownDepthLevel = -1
        var currentRootNode: CallGraphNode? = tree

        for symbol in symbols.dropFirst() {
            if symbol.depthLevel <= lastKnownDepthLevel {
                // find node with same level
                while currentRootNode != nil, currentRootNode?.symbol.depthLevel != symbol.depthLevel {
                    currentRootNode = currentRootNode?.parentNode
                }
                currentRootNode = currentRootNode?.parentNode
            }
            let newNode = CallGraphNode(symbol: symbol)
            newNode.parentNode = currentRootNode
            currentRootNode?.subNodes.append(newNode)
            currentRootNode = newNode
            lastKnownDepthLevel = symbol.depthLevel
        }
        return tree
    }
}
