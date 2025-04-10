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
        public init(
            id: String
        ) {
            self.id = id
        }
        
        /// The category ID.
        public let id: String
        
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
    
    /// A persisted category for favorite emojis.
    static let favorites = Self.init(id: "favorites")
    
    /// A persisted category for frequently used emojis.
    static let frequent = Self.init(id: "frequent")
    
    /// A persisted category for recent emojis.
    static let recent = Self.init(id: "recent")
}

public extension EmojiCategory.Persisted {
    
    /// The max number of emojis to store in the category.
    var emojisMaxCount: Int {
        get {
            let key = storageKey(for: .emojisMaxCount)
            let value = store.integer(forKey: key)
            return value < 1 ? 1_000 : value
        }
        set {
            let key = storageKey(for: .emojisMaxCount)
            return store.set(newValue, forKey: key)
        }
    }
    
    /// Add an emoji to the category.
    func addEmoji(
        _ emoji: Emoji
    ) {
        var emojis = getEmojis()
            .filter { $0 != emoji }
        emojis.insert(emoji, at: 0)
        setEmojis(emojis)
    }
    
    /// Get the persisted emojis for the category.
    func getEmojis() -> [Emoji] {
        let key = storageKey(for: .emojis)
        let value = store.stringArray(forKey: key) ?? []
        return value.map { Emoji($0) }
    }
    
    /// Remove an emoji from the category.
    func removeEmoji(
        _ emoji: Emoji
    ) {
        let emojis = getEmojis().filter { $0 != emoji }
        setEmojis(emojis)
    }
    
    /// Reset the emojis in the category.
    func resetEmojis() {
        setEmojis([])
    }

    /// Set the persisted emojis for the category.
    func setEmojis(
        _ emojis: [Emoji],
        applyMaxCount limit: Bool = true
    ) {
        let key = storageKey(for: .emojis)
        let emojiChars = emojis.map { $0.char }
        let value = limit ? Array(emojiChars.prefix(emojisMaxCount)) : Array(emojiChars)
        return store.set(value, forKey: key)
    }
}

private extension EmojiCategory.Persisted {
    
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
