// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "EmojiKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "EmojiKit",
            targets: ["EmojiKit"]
        )
    ],
    targets: [
        .target(
            name: "EmojiKit",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "EmojiKitTests",
            dependencies: ["EmojiKit"]
        )
    ]
)
