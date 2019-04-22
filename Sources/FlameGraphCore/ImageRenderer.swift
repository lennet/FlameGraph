#if canImport(Cocoa)
    import Cocoa

    public class ImageRenderer: CGBasedRenderer, Renderer {
        public class func render(graph: CallGraphNode) -> NSImage {
            let maxDepth = CGFloat(graph.maxDepth)
            return NSImage(size: NSSize(width: 1000, height: maxDepth * cellHeight), flipped: false) { (rect) -> Bool in
                let context = NSGraphicsContext.current!.cgContext

                renderLayer(nodes: [graph], context: context, totalWidth: rect.width, parentWidth: rect.width, y: 0, x: 0, maxPercentage: graph.symbol.percentage, height: cellHeight)
                return true
            }
        }
    }

    extension NSImage: RenderTarget {
        public func write(to url: URL) throws {
            enum WriteImageError: Error {
                case dataConversionFailed
            }

            guard let tiffRepresentation = tiffRepresentation,
                let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else {
                throw WriteImageError.dataConversionFailed
            }
            let imageData = bitmapImage.representation(using: .png, properties: [:])
            try imageData?.write(to: url)
        }
    }
#endif
