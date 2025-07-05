import Foundation

struct Renderer {

    let hash: [UInt8]
    let style: IdenticonStyle
    let fillColor: String
    let emptyFillColor: String
    let gridSize: Int
    let iconSize: Int

    public init(
        with hash: [UInt8],
        as style: IdenticonStyle,
        fillColor: String,
        emptyFillColor: String,
        gridSize: Int,
        iconSize: Int
    ) {
        self.hash = hash
        self.style = style
        self.fillColor = fillColor
        self.emptyFillColor = emptyFillColor
        self.gridSize = gridSize
        self.iconSize = iconSize
    }

    /// Render svg and return as string
    /// - Returns: generated svg string of Identicon
    public func renderSvg() -> String {
        let totalSize = gridSize * iconSize
        var svg = """
            <svg xmlns="http://www.w3.org/2000/svg" shape-rendering="crispEdges" width="\(totalSize)" height="\(totalSize)" viewBox="0 0 \(totalSize) \(totalSize)"><rect width="100%" height="100%" fill="#fff"/>
            """

        // Create symmetrical pattern using first N bytes of hash
        let shapeBitsPerCell = 3  // up to 8 shape types
        let halfColums = (gridSize + 1) / 2
        let centerCol = gridSize / 2  // Important when grid is odd sized
        var bitOffset = 0

        for row in 0..<gridSize {
            for col in 0..<halfColums {
                let byteIndex = bitOffset / 8
                let bitIndex = bitOffset % 8
                let shapeIndex =
                    (Int(hash[byteIndex]) >> (8 - shapeBitsPerCell - bitIndex))
                    & 0b111

                // Determine shape of cell
                var shape: CellShape
                if style == .simple || style == .dots {
                    shape = (shapeIndex % 2 == 0) ? .square : .empty
                } else {
                    shape = CellShape.from(shapeIndex)
                    if col == centerCol && gridSize % 2 == 1 {
                        let symmetricShapes: [CellShape] = [.square, .empty]
                        let hashByte = hash[bitOffset / 8]
                        shape =
                            symmetricShapes[
                                Int(hashByte) % symmetricShapes.count
                            ]
                    }
                }

                bitOffset += shapeBitsPerCell

                let x = col * iconSize
                let y = row * iconSize

                let path = createSvgPathForShape(
                    style: style,
                    shape: shape,
                    x: x,
                    y: y,
                    size: iconSize,
                    fill: fillColor,
                    emptyFill: emptyFillColor
                )
                svg += path

                // mirror cell
                if gridSize % 2 == 0 || col != centerCol {
                    let mirrorX = totalSize
                    let mirroredPath = createSvgPathForShape(
                        style: style,
                        shape: shape,
                        x: x,
                        y: y,
                        size: iconSize,
                        fill: fillColor,
                        emptyFill: emptyFillColor
                    )
                    svg += """
                        <g transform="translate(\(mirrorX),0) scale(-1,1)">\(mirroredPath)</g>
                        """
                }
            }
        }
        svg += "</svg>"
        return Utils.prettyPrint(svg)
    }

    /// Create svg path based on specified shape
    /// - Parameters:
    ///    - style: the identificon style
    ///    - shape: the shape to render for the cell
    ///    - x: the x coordinate in the grid
    ///    - y: the y coordinate in the grid
    ///    - size: the size of the icon
    ///    - fill: the fill color for the rendered shpes
    ///    - emptyFill: the fill color for the empty space
    /// - Returns: generated svg path for shape to be rendered in a cell
    func createSvgPathForShape(
        style: IdenticonStyle,
        shape: CellShape,
        x: Int,
        y: Int,
        size: Int,
        fill: String,
        emptyFill: String
    ) -> String {
        let overlap = 0.2
        let x1 = Double(x) - overlap
        let y1 = Double(y) - overlap
        let adjustedSize = Double(size) + (overlap * 2)
        let x2 = Double(x) + adjustedSize
        let y2 = Double(y) + adjustedSize
        let cx = x + size / 2
        let cy = y + size / 2
        let r = size / 2

        switch style {
        case .simple:
            if shape == .empty {
                return
                    "<rect x=\"\(x1)\" y=\"\(y1)\" width=\"\(adjustedSize)\" height=\"\(adjustedSize)\" fill=\"\(emptyFill)\"/>"
            }
            return
                "<rect x=\"\(x1)\" y=\"\(y1)\" width=\"\(adjustedSize)\" height=\"\(adjustedSize)\" fill=\"\(fill)\"/>"
        case .sharp:
            switch shape {
            case .square:
                return
                    "<rect x=\"\(x1)\" y=\"\(y1)\" width=\"\(adjustedSize)\" height=\"\(adjustedSize)\" fill=\"\(fill)\"/>"
            case .topLeft:
                return """
                    <g>
                        <rect x="\(x1)" y="\(y1)" width="\(adjustedSize)" height="\(adjustedSize)" fill="\(emptyFill)"/>
                        <path d="M \(x1) \(y1) L \(x2) \(y1) L \(x1) \(y2) Z" fill="\(fill)"/>
                    </g>
                    """
            case .topRight:
                return """
                    <g>
                        <rect x="\(x1)" y="\(y1)" width="\(adjustedSize)" height="\(adjustedSize)" fill="\(emptyFill)"/>
                        <path d="M \(x2) \(y1) L \(x2) \(y2) L \(x1) \(y1) Z" fill="\(fill)"/>
                    </g>
                    """
            case .bottomLeft:
                return """
                    <g>
                        <rect x="\(x1)" y="\(y1)" width="\(adjustedSize)" height="\(adjustedSize)" fill="\(emptyFill)"/>
                        <path d="M \(x1) \(y2) L \(x2) \(y2) L \(x1) \(y1) Z" fill="\(fill)"/>
                    </g>
                    """
            case .bottomRight:
                return """
                    <g>
                        <rect x="\(x1)" y="\(y1)" width="\(adjustedSize)" height="\(adjustedSize)" fill="\(emptyFill)"/>
                        <path d="M \(x2) \(y1) L \(x2) \(y2) L \(x1) \(y2) Z" fill="\(fill)"/>
                    </g>
                    """
            case .empty:
                return
                    "<rect x=\"\(x1)\" y=\"\(y1)\" width=\"\(adjustedSize)\" height=\"\(adjustedSize)\" fill=\"\(emptyFill)\"/>"
            }

        case .dots:
            if shape == .empty {
                return
                    "<rect x=\"\(x1)\" y=\"\(y1)\" width=\"\(adjustedSize)\" height=\"\(adjustedSize)\" fill=\"\(emptyFill)\"/>"
            }
            return """
                <g>
                    <rect x="\(x1)" y="\(y1)" width="\(adjustedSize)" height="\(adjustedSize)" fill="\(emptyFill)"/>
                    <circle cx=\"\(cx)\" cy=\"\(cy)\" r=\"\(r)\" fill=\"\(fill)\"/>
                </g>
                """

        case .rounded:
            switch shape {
            case .topLeft:
                return """
                    <g>
                        <rect x="\(x)" y="\(y)" width="\(adjustedSize)" height="\(adjustedSize)" fill="\(emptyFill)"/>
                        <path d="M \(x) \(Double(y) + adjustedSize) A \(adjustedSize) \(adjustedSize) 0 0 1 \(Double(x) + adjustedSize) \(y) L \(x) \(y) Z" fill="\(fill)"/>
                    </g>
                    """
            case .topRight:
                return """
                    <g>
                        <rect x="\(x)" y="\(y)" width="\(adjustedSize)" height="\(adjustedSize)" fill="\(emptyFill)"/>
                        <path d="M \(Double(x) + adjustedSize) \(Double(y) + adjustedSize) A \(size) \(size) 0 0 1 \(x) \(y) L \(x + size) \(y) Z" fill="\(fill)"/>
                    </g>
                    """
            case .bottomLeft:
                return """
                    <g>
                        <rect x="\(x)" y="\(y)" width="\(adjustedSize)" height="\(adjustedSize)" fill="\(emptyFill)"/>
                        <path d="M \(x) \(y) A \(size) \(adjustedSize) 0 0 1 \(x + size) \(Double(y) + adjustedSize) L \(x) \(Double(y) + adjustedSize) Z" fill="\(fill)"/>
                    </g>
                    """
            case .bottomRight:
                return """
                    <g>
                        <rect x="\(x)" y="\(y)" width="\(adjustedSize)" height="\(adjustedSize)" fill="\(emptyFill)"/>
                        <path d="M \(Double(x) + adjustedSize) \(y) A \(adjustedSize) \(adjustedSize) 0 0 1 \(x) \(Double(y) + adjustedSize) L \(Double(x) + adjustedSize) \(Double(y) + adjustedSize) Z" fill="\(fill)"/>
                    </g>
                    """
            case .square:
                return
                    "<rect x=\"\(x)\" y=\"\(y)\" width=\"\(adjustedSize)\" height=\"\(adjustedSize)\" fill=\"\(fill)\"/>"
            case .empty:
                return
                    "<rect x=\"\(x1)\" y=\"\(y1)\" width=\"\(adjustedSize)\" height=\"\(adjustedSize)\" fill=\"\(emptyFill)\"/>"
            }
        }
    }
}
