//
//  EmojiCategory+Persisted.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-08-23.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension EmojiCategory {
    
    /// This type can be used to handle persisted categories,
    /// where emojis can be customzied and persisted.
    ///
    /// You can use the predefined emoji categories, such as
    /// ``favorites``, and ``recent`` and set up custom ones
    /// to fit your needs.
    struct Persisted: Codable, Equatable, Hashable, Identifiable, Sendable {
        
        /// Create a custom persisted emoji category.
        ///
        /// - Parameters:
        ///   - id: The category ID.
        ///   - insertionStrategy: The insertion strategy to use.
        public init(
            id: String,
            insertionStrategy: EmojiInsertionStrategy
        ) {
            self.id = id
            self.insertionStrategy = insertionStrategy
        }
        
        /// The category ID.
        public let id: String
        
        /// The insertion strategy to use.
        public let insertionStrategy: EmojiInsertionStrategy
        
        /// The store to use.
        public var store: UserDefaults { .standard }
        
        /// Get the emojis storage key for custom category.
        ///
        /// > Note: This should be mutable, to allow customizing
        /// it for other storage requirements, like App Groups.
        static var storage: UserDefaults {
            .standard
        }
    }
}

public extension EmojiCategory.Persisted {
    
    /// A strategy that defines how new emojis are added.
    enum EmojiInsertionStrategy: Codable, Equatable, Sendable {
        
        /// Append new emojis last in the category.
        case append
        
        /// Insert new emojis first in the category.
        case insertFirst
    }
}

public extension EmojiCategory.Persisted {
    
    /// A persisted category for favorite emojis.
    static let favorites = Self.init(
        id: "favorites",
        insertionStrategy: .append
    )
    
    /// A persisted category for recent emojis.
    static let recent = Self.init(
        id: "recent",
        insertionStrategy: .insertFirst
    )
}

public extension EmojiCategory.Persisted {
    
    /// Add an emoji to the category.
    func addEmoji(
        _ emoji: Emoji
    ) {
        var emojis = getEmojis().filter { $0 != emoji }
        switch insertionStrategy {
        case .append: emojis.append(emoji)
        case .insertFirst: emojis.insert(emoji, at: 0)
        }
        setEmojis(emojis)
    }
    
    /// Get the persisted emojis for the category.
    func getEmojis() -> [Emoji] {
        let key = storageKey(for: .emojis)
        let value = store.stringArray(forKey: key) ?? []
        return value.map { Emoji($0) }
    }
    
    /// Get the max number of emojis to persist.
    func getEmojisMaxCount() -> Int {
        let key = storageKey(for: .emojisMaxCount)
        let value = store.integer(forKey: key)
        return value < 1 ? 1_000 : value
    }
    
    /// Remove an emoji from the category.
    func removeEmoji(
        _ emoji: Emoji
    ) {
        let emojis = getEmojis().filter { $0 != emoji }
        setEmojis(emojis)
    }
    
    /// Reset the category.
    func reset() {
        resetEmojis()
        resetEmojisMaxCount()
    }
    
    /// Reset the emojis in the category.
    func resetEmojis() {
        setEmojis([])
    }
    
    /// Reset the emojis max count for the category.
    func resetEmojisMaxCount() {
        setEmojisMaxCount(0)
    }

    /// Set the persisted emojis for the category.
    func setEmojis(
        _ emojis: [Emoji],
        applyMaxCount limit: Bool = true
    ) {
        let key = storageKey(for: .emojis)
        let emojis = limitEmojisForStorage(emojis)
        let chars = emojis.map { $0.char }
        return store.set(chars, forKey: key)
    }
    
    /// Set the max number of emojis to persist.
    func setEmojisMaxCount(_ val: Int) {
        let key = storageKey(for: .emojisMaxCount)
        return store.set(val, forKey: key)
    }
}

private extension EmojiCategory.Persisted {
    
    /// Limit a collection before persisting.
    func limitEmojisForStorage(
        _ emojis: [Emoji],
        applyMaxCount limit: Bool = true
    ) -> [Emoji] {
        guard limit else { return emojis }
        let maxCount = getEmojisMaxCount()
        guard maxCount > 0 else { return emojis }
        switch insertionStrategy {
        case .append: return Array(emojis.suffix(maxCount))
        case .insertFirst: return Array(emojis.prefix(maxCount))
        }
    }
    
    /// Get a storage key for a certain value.
    func storageKey(
        for value: String
    ) -> String {
        "com.emojikit.category.\(id.lowercased()).\(value)"
    }
}

private extension String {
    
    static let emojis = "emojis"
    static let emojisMaxCount = "emojisMaxCount"
}
