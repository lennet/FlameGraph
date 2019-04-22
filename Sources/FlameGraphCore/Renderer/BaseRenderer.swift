import Cocoa

public class BaseRenderer {
    static let colors: [NSColor] = [
        #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1),
        #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1),
        #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1),
        #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1),
        #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),
        #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
        #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
        #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
    ]

    static func text(for node: CallGraphNode) -> String {
        return "\(node.symbol.name), \(node.symbol.weight)"
    }
}

extension NSColor {
    var hex: String {
        let red = Int(round(redComponent * 0xFF))
        let green = Int(round(greenComponent * 0xFF))
        let blue = Int(round(blueComponent * 0xFF))
        let hexString = NSString(format: "#%02X%02X%02X", red, green, blue)
        return hexString as String
    }
}
