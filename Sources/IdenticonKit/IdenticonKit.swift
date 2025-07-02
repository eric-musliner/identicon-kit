import Crypto
import Foundation

public struct IdenticonKit {

    public init() {}

    /// Generates an identicon SVG based on the given input identifier.
    ///
    /// - Parameters:
    ///   - identifier: The string to hash (email, UUID, etc.)
    ///   - gridSize: Number of cells in the grid.
    ///   - iconSize: Size of the resulting icon.
    /// - Returns: A valid SVG string representing the identicon.
    public func generateSvg(
        from identifier: String,
        size: Int = 5,
        iconSize: Int = 40
    ) -> String {

        let generator = Generator(gridSize: size, iconSize: iconSize)
        return generator.generate(for: identifier)
    }
}
