import Crypto
import Foundation

public struct IdenticonKit {

    public enum IconSize: Int {
        case xsmall = 4
        case small = 5
        case medium = 8
        case large = 10
    }

    private init() {}

    /// Generates an identicon SVG based on the given input identifier.
    ///
    /// - Parameters:
    ///   - identifier: The string to hash (email, UUID, etc.)
    ///   - gridSize: Number of cells in the grid.
    ///   - iconSize: Size of the resulting icon.
    /// - Returns: A valid SVG string representing the identicon.
    static public func generateSvg(
        from identifier: String,
        size: IconSize = .small,
        iconSize: Int = 40
    ) -> String {

        let generator = Generator(gridSize: size.rawValue, iconSize: iconSize)
        return generator.generate(for: identifier)
    }
}
