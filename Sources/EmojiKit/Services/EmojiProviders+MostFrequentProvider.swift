//
//  EmojiProviders+MostRecentProvider.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, renamed: "EmojiProviders.MostRecentProvider")
public typealias MostRecentEmojiProvider = EmojiProviders.MostRecentProvider

public extension EmojiProviders {

    /// This emoji provider can be used to get the most recently
    /// used emojis.
    class MostRecentProvider: EmojiProvider {

        /// Create an instance of the provider.
        ///
        /// - Parameters:
        ///   - maxCount: The max number of emojis to remember, by default `30`.
        ///   - defaults: The store used to persist emojis, by default `.standard`.
        ///   - defaultsKey: The store key used to persist emojis, by default an EmojiKit-specific value.
        public init(
            maxCount: Int = 30,
            defaults: UserDefaults = .standard,
            defaultsKey: String = "com.emojikit.MostRecentEmojiProvider.emojis"
        ) {
            self.maxCount = maxCount
            self.defaults = defaults
            self.defaultsKey = defaultsKey
        }

        /// The max number of emojis to remember.
        public let defaults: UserDefaults

        /// The store used to persist emojis.
        public let defaultsKey: String

        /// The store key used to persist emojis.
        public let maxCount: Int
    }
}

public extension EmojiProviders.MostRecentProvider {

    var canAddEmojis: Bool { true }

    var emojis: [Emoji] {
        let chars = defaults.stringArray(forKey: defaultsKey) ?? []
        return chars.map { Emoji($0) }
    }

    func addEmoji(_ emoji: Emoji) {
        var emojis = self.emojis.filter { $0.char != emoji.char }
        emojis.insert(emoji, at: 0)
        let result = Array(emojis.prefix(maxCount))
        let chars = result.map { $0.char }
        defaults.set(chars, forKey: defaultsKey)
        defaults.synchronize()
    }

    func reset() {
        defaults.set([Emoji](), forKey: defaultsKey)
    }
}
