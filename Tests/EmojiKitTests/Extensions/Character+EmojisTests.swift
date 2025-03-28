//
//  Character+EmojiTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2023-12-31.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class Character_EmojisTests: XCTestCase {

    let combined = "☺️".char
    let nonCombined = "😀".char
    let simple = "😀".char
    let nonSimple = "⌚️".char

    func testIsCombinedEmojiReturnsTrueForSimpleAndCombinedEmojis() {
        XCTAssertTrue(combined.isCombinedEmoji)
        XCTAssertFalse(nonCombined.isCombinedEmoji)
    }

    func testIsSimpleEmojiReturnsTrueForSimpleAndCombinedEmojis() {
        XCTAssertTrue(simple.isSimpleEmoji)
        XCTAssertFalse(nonSimple.isSimpleEmoji)
    }
}

private extension String {

    var char: Character { Array(self)[0] }
}
