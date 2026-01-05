//
//  Emoji+UnicodeTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class Emoji_UnicodeTests: XCTestCase {
    
    func id(for emoji: String) -> String? {
        Emoji(emoji).unicodeIdentifier
    }
    
    func name(for emoji: String) -> String? {
        Emoji(emoji).unicodeName
    }
    
    func testUnicodeIdentifierIsRawValue() {
        XCTAssertEqual(id(for: "😀"), "\\N{GRINNING FACE}")
        XCTAssertEqual(id(for: "👍"), "\\N{THUMBS UP SIGN}")
        XCTAssertEqual(id(for: "👍🏿"), "\\N{THUMBS UP SIGN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-6}")
        XCTAssertEqual(id(for: "👰🏾‍♂️"), "\\N{BRIDE WITH VEIL}\\N{EMOJI MODIFIER FITZPATRICK TYPE-5}\\N{ZERO WIDTH JOINER}\\N{MALE SIGN}\\N{VARIATION SELECTOR-16}")
        XCTAssertEqual(id(for: "👩🏽‍❤️‍👨🏾"), "\\N{WOMAN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-4}\\N{ZERO WIDTH JOINER}\\N{HEAVY BLACK HEART}\\N{VARIATION SELECTOR-16}\\N{ZERO WIDTH JOINER}\\N{MAN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-5}")
        XCTAssertEqual(id(for: "🧑🏼‍❤️‍💋‍🧑🏿"), "\\N{ADULT}\\N{EMOJI MODIFIER FITZPATRICK TYPE-3}\\N{ZERO WIDTH JOINER}\\N{HEAVY BLACK HEART}\\N{VARIATION SELECTOR-16}\\N{ZERO WIDTH JOINER}\\N{KISS MARK}\\N{ZERO WIDTH JOINER}\\N{ADULT}\\N{EMOJI MODIFIER FITZPATRICK TYPE-6}")
    }
    
    func testUnicodeNameIsFormattedUnicodeIdentifier() {
        XCTAssertEqual(name(for: "😀"), "Grinning Face")
        XCTAssertEqual(name(for: "👍"), "Thumbs Up Sign")
        XCTAssertEqual(name(for: "👍🏿"), "Thumbs Up Sign Emoji Modifier Fitzpatrick Type-6")
        XCTAssertEqual(name(for: "👰🏾‍♂️"), "BRIDE WITH VEIL EMOJI MODIFIER FITZPATRICK TYPE-5 ZERO WIDTH JOINER MALE SIGN VARIATION SELECTOR-16".capitalized)
        XCTAssertEqual(name(for: "👩🏽‍❤️‍👨🏾"), "WOMAN EMOJI MODIFIER FITZPATRICK TYPE-4 ZERO WIDTH JOINER HEAVY BLACK HEART VARIATION SELECTOR-16 ZERO WIDTH JOINER MAN EMOJI MODIFIER FITZPATRICK TYPE-5".capitalized)
        XCTAssertEqual(name(for: "🧑🏼‍❤️‍💋‍🧑🏿"), "ADULT EMOJI MODIFIER FITZPATRICK TYPE-3 ZERO WIDTH JOINER HEAVY BLACK HEART VARIATION SELECTOR-16 ZERO WIDTH JOINER KISS MARK ZERO WIDTH JOINER ADULT EMOJI MODIFIER FITZPATRICK TYPE-6".capitalized)
    }
}
