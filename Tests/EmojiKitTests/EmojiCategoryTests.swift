//
//  EmojiCategoryTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class EmojisCategoryTests: XCTestCase {

    override func tearDown() {
        EmojiCategory.favoriteEmojis = []
        EmojiCategory.frequentEmojis = []
    }

    func emojiIcon(for cat: EmojiCategory) -> String {
        cat.emojiIcon
    }
    
    func firstEmoji(for cat: EmojiCategory) -> String {
        cat.emojis[0].char
    }

    func testCanReturnAllCategories() {
        XCTAssertEqual(EmojiCategory.standard, [
            .frequent,
            .smileysAndPeople,
            .animalsAndNature,
            .foodAndDrink,
            .activity,
            .travelAndPlaces,
            .objects,
            .symbols,
            .flags
        ])
    }

    func testCanGetAndSetFavoriteCategoryEmojis() async {
        XCTAssertEqual(EmojiCategory.favorites.emojis, [])
        let emojis: [Emoji] = [.init("😀")]
        EmojiCategory.favoriteEmojis = emojis
        XCTAssertEqual(EmojiCategory.favorites.emojis, emojis)
    }

    func testCanGetAndSetFrequentCategoryEmojis() async {
        XCTAssertEqual(EmojiCategory.frequent.emojis, [])
        let emojis: [Emoji] = [.init("😀")]
        EmojiCategory.frequentEmojis = emojis
        XCTAssertEqual(EmojiCategory.frequent.emojis, emojis)
    }

    func testHasCorrectEmojis() throws {
        XCTAssertEqual(firstEmoji(for: .smileysAndPeople), "😀")
        XCTAssertEqual(firstEmoji(for: .animalsAndNature), "🐶")
        XCTAssertEqual(firstEmoji(for: .foodAndDrink), "🍏")
        XCTAssertEqual(firstEmoji(for: .activity), "⚽️")
        XCTAssertEqual(firstEmoji(for: .travelAndPlaces), "🚗")
        XCTAssertEqual(firstEmoji(for: .objects), "⌚️")
        XCTAssertEqual(firstEmoji(for: .symbols), "🩷")
        XCTAssertEqual(firstEmoji(for: .flags), "🏳️")
    }
    
    func testHasEmojiBasedIcon() throws {
        XCTAssertEqual(emojiIcon(for: .frequent), "🕘")
        XCTAssertEqual(emojiIcon(for: .smileysAndPeople), "😀")
        XCTAssertEqual(emojiIcon(for: .animalsAndNature), "🐻")
        XCTAssertEqual(emojiIcon(for: .foodAndDrink), "🍔")
        XCTAssertEqual(emojiIcon(for: .activity), "⚽️")
        XCTAssertEqual(emojiIcon(for: .travelAndPlaces), "🏢")
        XCTAssertEqual(emojiIcon(for: .objects), "💡")
        XCTAssertEqual(emojiIcon(for: .symbols), "💱")
        XCTAssertEqual(emojiIcon(for: .flags), "🏳️")
    }
}
