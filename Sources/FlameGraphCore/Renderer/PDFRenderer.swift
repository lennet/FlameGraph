#if canImport(Cocoa)
    import Cocoa

    public class PDFRenderer: CGBasedRenderer, Renderer {
        public static func render(graph: CallGraphNode) -> Data {
            let maxDepth = CGFloat(graph.maxDepth)
            let data = NSMutableData()
            let consumer = CGDataConsumer(data: data)!
            var mediaBox = CGRect(origin: .zero, size: CGSize(width: 1000, height: maxDepth * cellHeight))

            let cgContext = CGContext(consumer: consumer, mediaBox: &mediaBox, nil)
            cgContext?.beginPDFPage(nil)

            renderLayer(nodes: [graph], context: cgContext!, totalWidth: mediaBox.width, parentWidth: mediaBox.width, y: 0, x: 0, maxPercentage: graph.symbol.percentage, height: cellHeight)

            cgContext?.endPDFPage()
            cgContext?.closePDF()

            return data as Data
        }

        override static func render(text: String, in rect: CGRect, context: CGContext) {
            context.saveGState()
            let attributedString = CFAttributedStringCreate(nil, text as CFString, nil) as! CFMutableAttributedString

            let font = CTFontCreateWithName("ArialMT" as CFString, 10, nil)
            let range = CFRangeMake(0, text.count)
            CFAttributedStringSetAttribute(attributedString, range, kCTFontAttributeName, font)
            CFAttributedStringSetAttribute(attributedString, range, kCTForegroundColorFromContextAttributeName, kCFBooleanTrue)
            context.setFillColor(CGColor.white)

            let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
            let framePath = CGMutablePath()
            framePath.addRect(rect)

            let currentRange = CFRangeMake(0, 0)
            let frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, nil)
            context.textMatrix = .identity

            // Center vertically in box and add Horizonal padding
            let suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, nil, rect.size, nil)
            let translationOffset = CGVector(dx: min(max((rect.width - suggestedSize.width) / 2, 0), 10),
                                             dy: -max((rect.height - suggestedSize.height) / 2, 0))
            context.translateBy(x: translationOffset.dx, y: translationOffset.dy)

            CTFrameDraw(frameRef, context)

            context.restoreGState()
        }
    }

#endif

extension Data: RenderTarget {
    public func write(to url: URL) throws {
        try write(to: url, options: [])
    }
}
