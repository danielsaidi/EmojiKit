//
//  Emoji+SkinToneTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2023-11-01.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class Emoji_SkinToneTests: XCTestCase {
    
    func hasVariants(_ emoji: String) -> Bool {
        Emoji(emoji).hasSkinToneVariants
    }
    
    func neutralVariant(for emoji: String) -> String {
        Emoji(emoji).neutralSkinToneVariant.char
    }
    
    func variants(for emoji: String) -> String {
        Emoji(emoji).skinToneVariants
            .map { $0.char }
            .joined()
    }

    func testHasSkinToneVariantsIsTrueForSomeEmojis() {
        XCTAssertTrue(hasVariants("👍"))
        XCTAssertFalse(hasVariants("🚀"))
    }

    func testNeutralSkinToneVariantIsDefinedForSomeEmojis() {
        XCTAssertEqual(neutralVariant(for: "👍"), "👍")
        XCTAssertEqual(neutralVariant(for: "👍🏿"), "👍")
        XCTAssertEqual(neutralVariant(for: "👨🏻‍🚒"), "👨‍🚒")
    }

    func testNeutralSkinToneVariantIsSameForSomeEmojis() throws {
        XCTAssertEqual(neutralVariant(for: "🚀"), "🚀")
    }

    func testSkinToneVariantIsDefinedForSomeEmojis() {
        XCTAssertEqual(variants(for: "👍"), "👍👍🏻👍🏼👍🏽👍🏾👍🏿")
        XCTAssertEqual(variants(for: "👍🏿"), "👍👍🏻👍🏼👍🏽👍🏾👍🏿")
        XCTAssertEqual(variants(for: "👨🏻‍🚒"), "👨‍🚒👨🏻‍🚒👨🏼‍🚒👨🏽‍🚒👨🏾‍🚒👨🏿‍🚒")
    }

    func testSkinToneVariantIsEmptyForSomeEmojis() throws {
        XCTAssertEqual(variants(for: "🚀").count, 0)
    }
}
