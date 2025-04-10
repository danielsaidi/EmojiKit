//
//  EmojiCategory+PersistedTests.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2025-04-10.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import EmojiKit
import Testing

class EmojiCategoryPersistedTests {
    
    let coffee = Emoji("☕️")
    let laptop = Emoji("💻")
    let rocket = Emoji("🚀")
    
    @Test func testCanGetAndSetEmojisInStandardCategories() async throws {
        let favorites = EmojiCategory.Persisted.favorites
        let recent = EmojiCategory.Persisted.recent
        favorites.reset()
        recent.reset()
        favorites.addEmoji(coffee)
        favorites.addEmoji(laptop)
        favorites.addEmoji(rocket)
        #expect(favorites.getEmojis() == [coffee, laptop, rocket])
        #expect(recent.getEmojis().isEmpty)
        print(recent.getEmojisMaxCount())
        recent.addEmoji(coffee)
        recent.addEmoji(laptop)
        recent.addEmoji(rocket)
        #expect(recent.getEmojis() == [rocket, laptop, coffee])
    }
    
    @Test func testCanUseAppendingInsertionStrategy() async throws {
        let category = EmojiCategory.Persisted(
            id: "testCanUseAppendingInsertionStrategy",
            insertionStrategy: .append
        )
        category.reset()
        category.addEmoji(coffee)
        category.addEmoji(laptop)
        category.addEmoji(rocket)
        #expect(category.getEmojis() == [coffee, laptop, rocket])
    }
    
    @Test func testCanUseInsertFirstInsertionStrategy() async throws {
        let category = EmojiCategory.Persisted(
            id: "testCanUseInsertFirstInsertionStrategy",
            insertionStrategy: .insertFirst
        )
        category.reset()
        category.addEmoji(coffee)
        category.addEmoji(laptop)
        category.addEmoji(rocket)
        #expect(category.getEmojis() == [rocket, laptop, coffee])
    }
    
    @Test func testInsertingRemovesExistingCopy() async throws {
        let category = EmojiCategory.Persisted(
            id: "testInsertingRemovesExistingCopy",
            insertionStrategy: .append
        )
        category.reset()
        #expect(category.getEmojis().isEmpty)
        category.addEmoji(rocket)
        category.addEmoji(laptop)
        category.addEmoji(coffee)
        #expect(category.getEmojis() == [rocket, laptop, coffee])
        category.addEmoji(rocket)
        #expect(category.getEmojis() == [laptop, coffee, rocket])
    }
    
    @Test func testCanSpecifyCustomMaxCountWithAppendInsertionStrategy() async throws {
        let category = EmojiCategory.Persisted(
            id: "testCanSpecifyCustomMaxCountWithAppendInsertionStrategy",
            insertionStrategy: .append
        )
        category.reset()
        category.setEmojisMaxCount(2)
        #expect(category.getEmojis().isEmpty)
        category.addEmoji(rocket)
        category.addEmoji(laptop)
        category.addEmoji(coffee)
        #expect(category.getEmojis() == [laptop, coffee])
    }
    
    @Test func testCanSpecifyCustomMaxCountWithInsertFirstInsertionStrategy() async throws {
        let category = EmojiCategory.Persisted(
            id: "testCanSpecifyCustomMaxCountWithInsertFirstInsertionStrategy",
            insertionStrategy: .insertFirst
        )
        category.reset()
        category.setEmojisMaxCount(1)
        #expect(category.getEmojis().isEmpty)
        category.addEmoji(rocket)
        category.addEmoji(laptop)
        #expect(category.getEmojis() == [laptop])
        category.setEmojisMaxCount(2)
        category.addEmoji(coffee)
        #expect(category.getEmojis() == [coffee, laptop])
    }
}
