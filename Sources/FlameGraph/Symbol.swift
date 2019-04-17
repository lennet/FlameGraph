import Foundation

struct Symbol {
    let weight: String
    let selfWeight: String
    let name: String
    let depthLevel: Int
    let percentage: Float
}

extension Symbol {
    init(weight: String, selfWeight: String, symbolName: String) {
        let weightComponent = weight.split(separator: Character(" "))
        self.weight = weightComponent[0 ..< weightComponent.count - 1].joined()
        self.selfWeight = selfWeight
        let trimmedSymbolName = symbolName.trimmingCharacters(in: .whitespaces)
        name = trimmedSymbolName
        depthLevel = symbolName.count - trimmedSymbolName.count
        percentage = Float(String(weightComponent.last!).replacingOccurrences(of: "%", with: "")) ?? 0
    }
}
