import Testing
@testable import IdenticonKit

@Test 
func testSvgGeneration() async throws {
    let generator = IdenticonKit()
    let svg = generator.generateSvg(from: "test@example.com")
    print(svg)
}

 @Test 
 func testSvgGenerationChangeResolution() async throws {
     let generator = IdenticonKit()
     let svg = generator.generateSvg(from: "test@example.com", size: 10)
     print(svg)
 }

 @Test 
 func testSvgGenerationDifferentColor() async throws {
     let generator = IdenticonKit()
     let svg = generator.generateSvg(from: "user@example.com", size: 10)
     print(svg)
 }
