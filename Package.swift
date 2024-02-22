// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "EmojiKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
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
