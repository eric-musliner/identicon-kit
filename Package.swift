// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "IdenticonKit",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "IdenticonKit",
            targets: ["IdenticonKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0"..<"4.0.0")
    ],
    targets: [
        .target(
            name: "IdenticonKit",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto")
            ]
        ),
        .testTarget(
            name: "IdenticonKitTests",
            dependencies: ["IdenticonKit"],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
