// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "EmojiKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2)
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
