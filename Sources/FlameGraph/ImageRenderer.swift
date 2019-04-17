import Cocoa

class ImageRenderer {
    class func render(graph: CallGraphNode) -> NSImage {
        let maxDepth = CGFloat(graph.maxDepth)
        let cellHeight: CGFloat = 40
        return NSImage(size: NSSize(width: 1000, height: maxDepth * cellHeight), flipped: false) { (rect) -> Bool in
            let context = NSGraphicsContext.current!.cgContext

            renderLayer(nodes: graph.subNodes, context: context, totalWidth: rect.width, y: 0, x: 0, maxPercentage: graph.symbol.percentage, height: cellHeight)
            return true
        }
    }

    private class func renderLayer(nodes: [CallGraphNode], context: CGContext, totalWidth: CGFloat, y: CGFloat, x: CGFloat, maxPercentage: Float, height: CGFloat) {
        let colors: [NSColor] = [
            #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1),
            #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1),
            #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1),
            #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1),
            #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),
            #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
            #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
            #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
        ]

        let xSpacing: CGFloat = 1
        let ySpacing: CGFloat = 1
        var currentX: CGFloat = x
        for node in nodes {
            let currentWidth = max(totalWidth * CGFloat(node.symbol.percentage / maxPercentage), 2)
            let rect = CGRect(x: currentX, y: y, width: currentWidth, height: height)
            colors.randomElement()?.setFill()
            context.fill(rect)

            NSString(string: "\(node.symbol.name), \(node.symbol.weight)").draw(in: rect, withAttributes: [.foregroundColor: NSColor.white])
            renderLayer(nodes: node.subNodes, context: context, totalWidth: currentWidth, y: y + height + ySpacing, x: currentX, maxPercentage: maxPercentage, height: height)
            currentX = rect.maxX + xSpacing
        }
    }
}

extension NSImage {
    func write(to _: URL) throws {
        enum WriteImageError: Error {
            case dataConversionFailed
        }

        guard let tiffRepresentation = image.tiffRepresentation,
            let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else {
            throw WriteImageError.dataConversionFailed
        }
        let imageData = bitmapImage.representation(using: .png, properties: [:])
        try imageData?.write(to: URL(fileURLWithPath: CommandLine.arguments[2]))
    }
}
