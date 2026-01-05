//
//  Emoji+LocalizationTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2026 Daniel Saidi. All rights reserved.
//

import XCTest
import EmojiKit

final class Emoji_LocalizationTests: XCTestCase {
    
    func key(for emoji: String) -> String {
        Emoji(emoji).localizationKey
    }
    
    func name(for emoji: String) -> String {
        Emoji(emoji).localizedName
    }
    
    func name(for emoji: String, locale: Locale) -> String {
        Emoji(emoji).localizedName(in: locale)
    }
    
    func testLocalizationKeyIsValid() {
        XCTAssertEqual(key(for: "😀"), "😀")
        XCTAssertEqual(key(for: "🧑🏼‍❤️‍💋‍🧑🏿"), "🧑🏼‍❤️‍💋‍🧑🏿")
    }
    
    func testLocalizedNameHasDefaultValue() {
        let current1 = name(for: "😀", locale: .current)
        XCTAssertEqual(name(for: "😀"), current1)
        let current2 = name(for: "😄", locale: .current)
        XCTAssertEqual(name(for: "😄"), current2)
    }
    
    func testLocalizedNameIsAvailableInEnglish() {
        let locale = Locale.english
        XCTAssertEqual(name(for: "😀", locale: locale), "Grinning Face")
    }
    
    func testLocalizedNameIsAvailableInSwedish() {
        let locale = Locale.swedish
        XCTAssertEqual(name(for: "😀", locale: locale), "Leende ansikte")
    }
    
    func testLocalizedNameHasFallbackForUnsupportedLocales() {
        let emoji = Emoji("😀")
        XCTAssertEqual(
            emoji.localizedName(in: .finnish),
            emoji.localizedName(in: .current)
        )
    }
}
