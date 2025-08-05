import Foundation
import Testing

@testable import IdenticonKit

@Test
func testGenerateSvgRounded() async throws {
    let svg = IdenticonKit.generateSvg(from: "test@example.com")

    let expected = try loadFixture("test_rounded.svg")
    #expect(normalizeWhitespace(expected) == normalizeWhitespace(svg))
}

@Test
func testGenerateSvgRounded2() async throws {
    let svg = IdenticonKit.generateSvg(from: "123@gmail.com")

    let expected = try loadFixture("test_rounded2.svg")
    #expect(normalizeWhitespace(expected) == normalizeWhitespace(svg))
}

@Test
func testGenerateSvgRoundedLarge() async throws {
    let svg = IdenticonKit.generateSvg(from: "test@example.com", size: .large)

    let expected = try loadFixture("test_rounded_large.svg")
    #expect(normalizeWhitespace(expected) == normalizeWhitespace(svg))
}

@Test
func testGenerateSvgSharpSmall() async throws {
    let svg = IdenticonKit.generateSvg(from: "test_user@mail.com", size: .xsmall)

    let expected = try loadFixture("test_sharp_small.svg")
    #expect(normalizeWhitespace(expected) == normalizeWhitespace(svg))
}

@Test
func testGenerateSvgSharpLarge() async throws {
    let svg = IdenticonKit.generateSvg(from: "123_user@outlook.us", size: .large)

    let expected = try loadFixture("test_sharp_large.svg")
    #expect(normalizeWhitespace(expected) == normalizeWhitespace(svg))
}

@Test
func testGenerateSvgSharp() async throws {
    let svg = IdenticonKit.generateSvg(from: "biz@email.us")

    let expected = try loadFixture("test_sharp.svg")
    #expect(normalizeWhitespace(expected) == normalizeWhitespace(svg))
}

@Test
func testGenerateSvgDots() async throws {
    let svg = IdenticonKit.generateSvg(from: "short@blah.mil")

    let expected = try loadFixture("test_dots.svg")
    #expect(normalizeWhitespace(expected) == normalizeWhitespace(svg))
}

/// Load expected SVG from test resources
private func loadFixture(_ name: String) throws -> String {
    let file = #filePath
    let dir = URL(fileURLWithPath: file)
        .deletingLastPathComponent()
        .appendingPathComponent("Resources")
    let path = dir.appendingPathComponent(name)

    return try String(contentsOf: path, encoding: .utf8)
}

/// Normalize whitespace for stable comparison
private func normalizeWhitespace(_ string: String) -> String {
    string
        .replacingOccurrences(
            of: "\\s+",
            with: " ",
            options: .regularExpression
        )
        .trimmingCharacters(in: .whitespacesAndNewlines)
}
