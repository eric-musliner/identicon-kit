import Crypto
import Foundation

struct Utils {

    /// Lighten color by specified amount
    /// - Parameters:
    ///    - hex: the starting color as hex string
    ///    - amount: the amount each RGB channel should move toward full white (255)
    /// - Returns: lightened color in hex string
    static func lightenColor(hex: String, amount: Double) -> String {
        guard hex.hasPrefix("#"), hex.count == 7 else { return hex }
        let r = Int(hex.dropFirst(1).prefix(2), radix: 16) ?? 0
        let g = Int(hex.dropFirst(3).prefix(2), radix: 16) ?? 0
        let b = Int(hex.dropFirst(5).prefix(2), radix: 16) ?? 0

        func lighten(_ component: Int) -> Int {
            return min(
                255,
                Int(Double(component) + (255.0 - Double(component)) * amount)
            )
        }

        let newR = lighten(r)
        let newG = lighten(g)
        let newB = lighten(b)

        return String(format: "#%02x%02x%02x", newR, newG, newB)
    }

    /// Generate hash of identifier string
    /// - Parameters:
    ///    - input: string input to hash
    /// - Returns: array of hash values
    static func hash(_ input: String) -> [UInt8] {
        let data = Data(input.utf8)
        let hash = SHA256.hash(data: data)
        return Array(hash)
    }

    /// Pretty print SVG xml
    /// - Parameters:
    ///    - rawXml: raw XML to pretty print
    /// - Returns: pretty printed XML string
    static func prettyPrint(_ xml: String) -> String {
        xml
            .replacingOccurrences(of: "><", with: ">\n<")
            .components(separatedBy: .newlines)
            .reduce(into: (0, "")) { acc, line in
                var (indent, result) = acc
                let trimmed = line.trimmingCharacters(in: .whitespaces)
                if trimmed.hasPrefix("</") { indent = max(indent - 1, 0) }
                result +=
                    String(repeating: "  ", count: indent) + trimmed + "\n"
                if trimmed.hasPrefix("<") && !trimmed.hasPrefix("</")
                    && !trimmed.contains("/>")
                {
                    indent += 1
                }
                acc = (indent, result)
            }.1
    }

}
