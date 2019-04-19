import Foundation

public struct Symbol: Equatable {
    public let weight: String
    public let selfWeight: String
    public let name: String
    public let depthLevel: Int
    public let percentage: Float
}

public extension Symbol {
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
