//
//  Emoji+AllTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class Emojis_AllTests: XCTestCase {
    
    func testEmojiCanReturnAllEmojis() {
        let emojis = Emoji.all
        XCTAssertGreaterThan(emojis.count, 1)
        Emoji.all.forEach {
            XCTAssertEqual($0.id, $0.char)
        }
    }
}
