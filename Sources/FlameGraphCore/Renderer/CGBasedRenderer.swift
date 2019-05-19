#if canImport(Cocoa)
    import Cocoa

    public class CGBasedRenderer: BaseRenderer {
        static let cellHeight: CGFloat = 40

        class func renderLayer(nodes: [CallGraphNode], context: CGContext, totalWidth: CGFloat, parentWidth: CGFloat, y: CGFloat, x: CGFloat, maxPercentage: Float, height: CGFloat) {
            let xSpacing: CGFloat = 1
            let ySpacing: CGFloat = 1
            var currentX: CGFloat = x
            for node in nodes {
                var currentWidth = totalWidth * CGFloat(node.symbol.percentage / maxPercentage)
                if currentWidth < 1 || currentWidth.isNaN {
                    currentWidth = min(parentWidth / CGFloat(node.parentNode?.subNodes.count ?? 1), 1)
                }

                let rect = CGRect(x: currentX, y: y, width: currentWidth, height: height)

                context.setFillColor(colors.randomElement()!.cgColor)
                context.fill(rect)

                render(text: text(for: node), in: rect, context: context)

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
