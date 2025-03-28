//
//  EmojiCategory+LocalizationTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import XCTest
import EmojiKit

final class EmojiCategory_LocalizationTests: XCTestCase {
    
    func key(for cat: EmojiCategory) -> String {
        cat.localizationKey
    }
    
    func name(for cat: EmojiCategory) -> String {
        cat.localizedName
    }
    
    func name(for cat: EmojiCategory, locale: Locale) -> String {
        cat.localizedName(in: locale)
    }
    
    func testLocalizationKeyIsValid() {
        XCTAssertEqual(key(for: .frequent), "EmojiCategory.frequent")
        XCTAssertEqual(key(for: .smileysAndPeople), "EmojiCategory.smileysAndPeople")
        XCTAssertEqual(key(for: .animalsAndNature), "EmojiCategory.animalsAndNature")
        XCTAssertEqual(key(for: .foodAndDrink), "EmojiCategory.foodAndDrink")
        XCTAssertEqual(key(for: .activity), "EmojiCategory.activity")
        XCTAssertEqual(key(for: .travelAndPlaces), "EmojiCategory.travelAndPlaces")
        XCTAssertEqual(key(for: .objects), "EmojiCategory.objects")
        XCTAssertEqual(key(for: .symbols), "EmojiCategory.symbols")
        XCTAssertEqual(key(for: .flags), "EmojiCategory.flags")
    }
    
    func testLocalizedNameHasDefaultValue() {
        let current1 = name(for: .activity, locale: .current)
        XCTAssertEqual(name(for: .activity), current1)
        let current2 = name(for: .objects, locale: .current)
        XCTAssertEqual(name(for: .objects), current2)
    }
    
    func testLocalizedNameIsAvailableInEnglish() {
        let locale = Locale.english
        XCTAssertEqual(name(for: .frequent, locale: locale), "Frequently Used")
        XCTAssertEqual(name(for: .smileysAndPeople, locale: locale), "Smileys & People")
        XCTAssertEqual(name(for: .animalsAndNature, locale: locale), "Animals & Nature")
        XCTAssertEqual(name(for: .foodAndDrink, locale: locale), "Food & Drink")
        XCTAssertEqual(name(for: .activity, locale: locale), "Activity")
        XCTAssertEqual(name(for: .travelAndPlaces, locale: locale), "Travel & Places")
        XCTAssertEqual(name(for: .objects, locale: locale), "Objects")
        XCTAssertEqual(name(for: .symbols, locale: locale), "Symbols")
        XCTAssertEqual(name(for: .flags, locale: locale), "Flags")
    }
    
    func testLocalizedNameIsAvailableInSwedish() {
        let locale = Locale.swedish
        XCTAssertEqual(name(for: .frequent, locale: locale), "Ofta använda")
        XCTAssertEqual(name(for: .smileysAndPeople, locale: locale), "Smileys och människor")
        XCTAssertEqual(name(for: .animalsAndNature, locale: locale), "Djur och natur")
        XCTAssertEqual(name(for: .foodAndDrink, locale: locale), "Mat och dryck")
        XCTAssertEqual(name(for: .activity, locale: locale), "Aktivitet")
        XCTAssertEqual(name(for: .travelAndPlaces, locale: locale), "Resor och platser")
        XCTAssertEqual(name(for: .objects, locale: locale), "Objekt")
        XCTAssertEqual(name(for: .symbols, locale: locale), "Symboler")
        XCTAssertEqual(name(for: .flags, locale: locale), "Flaggor")
    }
    
    func testLocalizedNameHasFallbackForUnsupportedLocales() {
        let emoji = Emoji("😀")
        XCTAssertEqual(
            emoji.localizedName(in: .finnish),
            emoji.localizedName(in: .current)
        )
    }
}
