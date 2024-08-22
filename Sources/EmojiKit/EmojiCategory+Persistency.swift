//
//  EmojiCategory+Custom.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-08-23.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension EmojiCategory {

    /// A persisted list of emojis, that will be used by the
    /// ``EmojiCategory/favorites`` category.
    static var favoriteEmojis: [Emoji] {
        get { getPersistedEmojis(for: "favorites") }
        set { setPersistedEmojis(newValue, for: "favorites") }
    }

    /// A persisted list of emojis, that will be used by the
    /// ``EmojiCategory/frequent`` category.
    static var frequentEmojis: [Emoji] {
        get { getPersistedEmojis(for: "frequent") }
        set { setPersistedEmojis(newValue, for: "frequent") }
    }
}

extension EmojiCategory {

    /// Get a persisted list of emojis for a category.
    static func getPersistedEmojis(
        for category: String
    ) -> [Emoji] {
        let storage = persistedStorage
        let key = persistedStorageKey(for: category)
        let string = storage.stringArray(forKey: key) ?? []
        return string.map { Emoji($0) }
    }

    /// Get a persisted list of emojis for a category.
    static func setPersistedEmojis(
        _ emojis: [Emoji],
        for category: String
    ) {
        let storage = persistedStorage
        let key = persistedStorageKey(for: category)
        let chars = emojis.map { $0.char }
        return storage.set(chars, forKey: key)
    }

    /// Get the emojis storage key for custom category.
    ///
    /// > Important: This is currently read-only, but should
    /// be mutable in the future, to be able to customize it
    /// for other storage requirements, like App Groups.
    static var persistedStorage: UserDefaults {
        .standard
    }

    /// Get the emojis storage key for custom category.
    static func persistedStorageKey(
        for category: String
    ) -> String {
        "com.emojikit.category.\(category).emojis"
    }
}
