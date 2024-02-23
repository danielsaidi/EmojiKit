//
//  Emoji+LocalizationTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import EmojiKit

final class Emoji_LocalizationTests: XCTestCase {
    
    let english = Locale(identifier: "en-US")
    let swedish = Locale(identifier: "sv")
    let finnish = Locale(identifier: "fi")
    
    func testLocalizationKeyIsValid() {
        let value = Emoji("😀").localizationKey
        XCTAssertEqual(value, "😀")
    }
    
    func testLocalizedNameIsValidForManyLocales() {
        let emoji = Emoji("😀")
        XCTAssertEqual(emoji.localizedName(for: english), "Grinning Face")
        XCTAssertEqual(emoji.localizedName(for: swedish), "Leende ansikte")
    }
    
    func testLocalizedNameHasCurrentLocaleFallback() {
        let emoji = Emoji("😀")
        XCTAssertEqual(emoji.localizedName(for: english), "Grinning Face")
        XCTAssertEqual(
            emoji.localizedName(for: finnish),
            emoji.localizedName(for: .current)
        )
    }
}
