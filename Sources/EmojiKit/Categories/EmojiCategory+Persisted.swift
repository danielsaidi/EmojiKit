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
    /// ``favorites``, and ``recent`` and set up custom ones.
    struct Persisted: Codable, Equatable, Hashable, Identifiable, Sendable {
        
        /// Create a custom persisted emoji category.
        ///
        /// - Parameters:
        ///   - id: The category ID.
        ///   - name: The category name.
        ///   - iconName: The category icon name.
        ///   - initialEmojis: The emojis to initialize the category with, if any.
        ///   - insertionStrategy: The insertion strategy to use when adding emojis.
        public init(
            id: String,
            name: String,
            iconName: String,
            initialEmojis: [Emoji] = [],
            insertionStrategy: InsertionStrategy
        ) {
            self.id = id
            self.name = name
            self.iconName = iconName
            self.initialEmojis = initialEmojis
            self.insertionStrategy = insertionStrategy
        }
        
        /// Create a custom persisted emoji category with an
        /// internal, localized name.
        ///
        /// - Parameters:
        ///   - id: The category ID.
        ///   - iconName: The category icon name.
        ///   - initialEmojis: The emojis to initialize the category with, if any.
        ///   - insertionStrategy: The insertion strategy to use when adding emojis.
        init(
            id: String,
            iconName: String,
            initialEmojis: [Emoji] = [],
            insertionStrategy: InsertionStrategy
        ) {
            self.init(
                id: id,
                name: "",
                iconName: iconName,
                initialEmojis: initialEmojis,
                insertionStrategy: insertionStrategy
            )
        }
        
        /// The category ID.
        public let id: String
        
        /// The category name.
        public private(set) var name: String
        
        /// The category icon name.
        public let iconName: String

        /// The default emojis to return if no data is saved.
        public let initialEmojis: [Emoji]

        /// The insertion strategy to use.
        public let insertionStrategy: InsertionStrategy
        
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
    enum InsertionStrategy: Codable, Equatable, Sendable {
        
        /// Append new emojis last in the category.
        case append

        /// Insert new emojis with a frequent strategy.
        case frequent

        /// Insert new emojis first in the category.
        case insertFirst
    }
}

public extension EmojiCategory.Persisted {
    
    /// A persisted category for favorite emojis.
    static let favorites = Self.init(
        id: "favorites",
        iconName: "heart",
        insertionStrategy: .append
    )

    /// A persisted category for frequently used emojis.
    static let frequent = Self.init(
        id: "frequent",
        iconName: "clock",
        insertionStrategy: .frequent
    )

    /// A persisted category for recent emojis.
    static let recent = Self.init(
        id: "recent",
        iconName: "clock",
        insertionStrategy: .insertFirst
    )
}

public extension EmojiCategory.Persisted {
    
    /// Add an emoji to the category.
    func addEmoji(_ emoji: Emoji) {
        switch insertionStrategy {
        case .frequent: FrequentEmojis.add(emoji: emoji, maxCount: getEmojisMaxCount())
        case .append, .insertFirst:
            let emojis = getEmojis()
            let new = emojis.inserting(emoji, with: insertionStrategy)
            setEmojis(new)
        }
    }

    /// Get the persisted emojis for the category.
    func getEmojis() -> [Emoji] {
        switch insertionStrategy {
        case .frequent: return FrequentEmojis.emojis
        case .append, .insertFirst:
            let key = storageKey(for: .emojis)
            let value = store.stringArray(forKey: key)
            guard let value else { return initialEmojis }
            return value.map { Emoji($0) }
        }
    }
    
    /// Get the max number of emojis to persist.
    func getEmojisMaxCount() -> Int {
        let key = storageKey(for: .emojisMaxCount)
        let value = store.integer(forKey: key)
        return value < 1 ? 1_000 : value
    }
    
    /// Remove an emoji from the category.
    func removeEmoji(_ emoji: Emoji) {
        switch insertionStrategy {
        case .frequent: FrequentEmojis.removeEmoji(emoji)
        case .append, .insertFirst:
            let emojis = getEmojis().filter { $0 != emoji }
            setEmojis(emojis)
        }
    }
    
    /// Reset the category.
    func reset() {
        switch insertionStrategy {
        case .frequent: FrequentEmojis.reset()
        case .append, .insertFirst:
            resetEmojis()
            resetEmojisMaxCount()
        }
    }
    
    /// Reset the category emojis to its initial value.
    func resetEmojis() {
        setEmojis(nil)
    }
    
    /// Reset the category max count.
    func resetEmojisMaxCount() {
        setEmojisMaxCount(0)
    }

    /// Set the persisted emojis for the category.
    func setEmojis(_ emojis: [Emoji]?) {
        switch insertionStrategy {
        case .frequent: FrequentEmojis.setEmojis(emojis)
        case .append, .insertFirst:
            let key = storageKey(for: .emojis)
            guard let emojis else { return store.removeObject(forKey: key)}
            let maxCount = getEmojisMaxCount()
            let capped = emojis.capped(to: maxCount, with: insertionStrategy)
            let cappedData = capped.map { $0.char }
            store.set(cappedData, forKey: key)
        }
    }
    
    /// Set the max number of emojis to persist.
    func setEmojisMaxCount(_ val: Int) {
        let key = storageKey(for: .emojisMaxCount)
        return store.set(val, forKey: key)
    }
}

private extension Collection where Element == Emoji {

    func capped(to maxCount: Int, with strategy: EmojiCategory.Persisted.InsertionStrategy) -> [Element] {
        guard maxCount > 0 else { return Array(self) }
        switch strategy {
        case .append: return Array(suffix(maxCount))
        case .frequent: return Array(self)
        case .insertFirst: return Array(prefix(maxCount))
        }
    }

    func inserting(_ emoji: Emoji, with strategy: EmojiCategory.Persisted.InsertionStrategy) -> [Element] {
        var emojis = self.filter { $0 != emoji }
        switch strategy {
        case .append: emojis.append(emoji)
        case .frequent: break
        case .insertFirst: emojis.insert(emoji, at: 0)
        }
        return emojis
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
