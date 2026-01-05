//
//  FrequentEmojis.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2025-09-20.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import Foundation

/// This internal class is used to manage emojis with recent
/// and frequency considerations.
final class FrequentEmojis: @unchecked Sendable {

    private init() {}

    private static var defaults: UserDefaults { .standard }
    private static let emojisKey = "com.emojikit.category.frequent.emojis"
    private static let frequencyKey = "com.emojikit.category.frequent.frequencies"
}

extension FrequentEmojis {

    static var emojis: [Emoji] {
        get {
            let array = defaults.stringArray(forKey: emojisKey)
            guard let array else { return [] }
            let emojis = array.map { Emoji($0) }
            return emojis
        }
        set {
            let array = newValue.map { $0.char }
            defaults.set(array, forKey: emojisKey)
        }
    }

    static var frequencies: [String: Int] {
        get {
            let dict = defaults.dictionary(forKey: frequencyKey)
            return (dict as? [String: Int]) ?? [:]
        }
        set {
            defaults.set(newValue, forKey: frequencyKey)
        }
    }
}

extension FrequentEmojis {

    static func add(emoji: Emoji, maxCount: Int) {
        guard maxCount > 0 else {
            reset()
            return
        }

        var emojis = emojis
        var frequencies = frequencies

        // Update frequency
        let freq = frequencies[emoji.char] ?? 0
        let newFreq = freq + 1
        frequencies[emoji.char] = newFreq

        // Remove if already exists
        emojis.removeAll { $0 == emoji }

        // Find insertion index based on frequency
        // This uses binary search for efficiency.
        let index = findInsertionIndex(for: newFreq, in: emojis, frequencies: frequencies)
        emojis.insert(emoji, at: index)

        // Trim to max count and clean up frequencies
        if emojis.count > maxCount {
            let removed = emojis.suffix(from: maxCount)
            removed.forEach { frequencies.removeValue(forKey: $0.char) }
            emojis = Array(emojis.prefix(maxCount))
        }

        // Save data
        persist(emojis, frequencies)
    }

    static func removeEmoji(_ emoji: Emoji) {
        var emojis = emojis
        var frequencies = frequencies
        emojis.removeAll { $0 == emoji }
        frequencies.removeValue(forKey: emoji.char)
        persist(emojis, frequencies)
    }

    static func reset() {
        defaults.removeObject(forKey: emojisKey)
        defaults.removeObject(forKey: frequencyKey)
    }

    static func setEmojis(_ emojis: [Emoji]?) {
        guard let emojis = emojis, !emojis.isEmpty else {
            reset()
            return
        }

        // Filter frequencies to only include emojis we're setting
        let frequencies = frequencies.filter { key, _ in
            emojis.contains { $0.char == key }
        }

        // Sort the emojis by frequency
        let sortedEmojis = emojis.sorted { lhs, rhs in
            let leftFreq = frequencies[lhs.char] ?? 0
            let rightFreq = frequencies[rhs.char] ?? 0
            return leftFreq > rightFreq
        }

        persist(sortedEmojis, frequencies)
    }
}

private extension FrequentEmojis {

    static func persist(
        _ emojis: [Emoji],
        _ frequencies: [String: Int]
    ) {
        self.emojis = emojis
        self.frequencies = frequencies
    }
}

// MARK: - Private Helpers

private extension FrequentEmojis {

    /// Finds the correct insertion index to maintain frequency-based sorting
    /// Uses binary search for O(log n) performance
    static func findInsertionIndex(for frequency: Int, in emojis: [Emoji], frequencies: [String: Int]) -> Int {
        var left = 0
        var right = emojis.count

        while left < right {
            let mid = (left + right) / 2
            let midFreq = frequencies[emojis[mid].char] ?? 0

            if midFreq > frequency {
                left = mid + 1
            } else {
                right = mid
            }
        }

        return left
    }
}
