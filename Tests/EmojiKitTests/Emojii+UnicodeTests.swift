//
//  Emoji+UnicodeTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class Emoji_UnicodeTests: XCTestCase {
    
    func id(for emoji: String) -> String? {
        Emoji(emoji).unicodeIdentifier
    }
    
    func testUnicodeIdentifierIsRawValue() {
        XCTAssertEqual(id(for: "😀"), "\\N{GRINNING FACE}")
        XCTAssertEqual(id(for: "👍"), "\\N{THUMBS UP SIGN}")
        XCTAssertEqual(id(for: "👍🏿"), "\\N{THUMBS UP SIGN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-6}")
        XCTAssertEqual(id(for: "👩🏽‍❤️‍👨🏾"), "\\N{WOMAN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-4}\\N{ZERO WIDTH JOINER}\\N{HEAVY BLACK HEART}\\N{VARIATION SELECTOR-16}\\N{ZERO WIDTH JOINER}\\N{MAN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-5}")
    }
}
