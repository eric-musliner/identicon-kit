struct Generator {

    let gridSize: Int
    let iconSize: Int

    public init(gridSize: Int = 5, iconSize: Int = 40) {
        self.gridSize = gridSize
        self.iconSize = iconSize
    }

    /// Generate
    /// - Parameters:
    ///    - identifier: the identifier to hash
    /// - Returns: generated svg string of Identicon
    public func generate(for identifier: String) -> String {
        let hash = Utils.hash(
            identifier.lowercased().trimmingCharacters(
                in: .whitespacesAndNewlines
            )
        )
        let fillColor = String(
            format: "#%02x%02x%02x",
            hash[0],
            hash[1],
            hash[2]
        )
        let emptyFillColor = Utils.lightenColor(hex: fillColor, amount: 0.6)
        let style = styleFromHash(hash)

        let renderer = Renderer(
            with: hash,
            as: style,
            fillColor: fillColor,
            emptyFillColor: emptyFillColor,
            gridSize: gridSize,
            iconSize: iconSize
        )
        return renderer.renderSvg()

    }

    /// Determine style of Identicon based on hash
    /// - Parameters:
    ///    - hash: the hash value
    /// - Returns: style of Identicon
    private func styleFromHash(_ hash: [UInt8]) -> IdenticonStyle {
        let value = (hash[28] ^ hash[29] ^ hash[30] ^ hash[31]) % 4
        switch value {
        case 0: return .simple
        case 1: return .sharp
        case 2: return .rounded
        default: return .dots
        }
    }

}
