//
//  EmojiTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class EmojiTests: XCTestCase {

    func testCanBeCreatedWithCharacter() {
        let emoji = Emoji(Character("😀"))
        XCTAssertEqual(emoji.char, "😀")
    }
    
    func testCanBeCreatedWithString() {
        let emoji = Emoji("🤭")
        XCTAssertEqual(emoji.char, "🤭")
    }
    
    func testIdentifierIsUnique() {
        let emoji1 = Emoji("👍")
        let emoji2 = Emoji("👍🏿")
        XCTAssertEqual(emoji1.id, "👍")
        XCTAssertNotEqual(emoji1.id, "👍🏿")
        XCTAssertEqual(emoji2.id, "👍🏿")
        XCTAssertNotEqual(emoji2.id, "👍🏽")
    }
}

private extension String {

    var char: Character { Array(self)[0] }
}
