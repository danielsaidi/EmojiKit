//
//  Emoji+SkinToneTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2023-11-01.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
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

    /// This test races threads on emojis that are not cached
    /// yet, so that they all take the cache-populating write
    /// path at the same time. It must not warm the cache up
    /// first, since concurrent reads alone are harmless.
    func testHasSkinToneVariantsIsSafeToResolveConcurrently() {
        let emojis = "👍✌️👏🙏💪👋🤙👌🤝☝️✍️💅👂👃🧠🫀🦷👀🤳💃".map { Emoji(String($0)) }
        let expectation = expectation(description: "Concurrent resolves")
        expectation.expectedFulfillmentCount = 20

        for _ in 0..<20 {
            DispatchQueue.global().async {
                _ = emojis.map { $0.hasSkinToneVariants }
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 30)

        XCTAssertTrue(hasVariants("👍"))
        XCTAssertFalse(hasVariants("🚀"))
    }
}
