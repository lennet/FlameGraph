#if canImport(Cocoa)
    import Cocoa

    public class CGBasedRenderer {
        static let cellHeight: CGFloat = 40

        class func renderLayer(nodes: [CallGraphNode], context: CGContext, totalWidth: CGFloat, parentWidth: CGFloat, y: CGFloat, x: CGFloat, maxPercentage: Float, height: CGFloat) {
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
                var currentWidth = totalWidth * CGFloat(node.symbol.percentage / maxPercentage)
                if currentWidth < 1 {
                    currentWidth = min(parentWidth / CGFloat(node.parentNode?.subNodes.count ?? 1), 1)
                }

                let rect = CGRect(x: currentX, y: y, width: currentWidth, height: height)

                context.setFillColor(colors.randomElement()!.cgColor)
                context.fill(rect)

                render(text: "\(node.symbol.name), \(node.symbol.weight)", in: rect, context: context)

                renderLayer(nodes: node.subNodes, context: context, totalWidth: currentWidth, parentWidth: parentWidth, y: y + height + ySpacing, x: currentX, maxPercentage: node.symbol.percentage, height: height)
                currentX = rect.maxX + xSpacing
            }
        }

        class func render(text: String, in rect: CGRect, context _: CGContext) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byCharWrapping

            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: NSColor.white,
                                                             .paragraphStyle: paragraphStyle]
            let options: NSString.DrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]

            let string = NSString(string: text)
            var stringSize = string.boundingRect(with: rect.size, options: options, attributes: attributes).size
            stringSize.height = min(rect.height, stringSize.height)
            let stringRect = NSRect(x: rect.origin.x, y: rect.origin.y + (rect.height - stringSize.height) / 2,
                                    width: rect.width, height: stringSize.height)

            string.draw(with: stringRect, options: options, attributes: attributes)
        }
    }
#endif
