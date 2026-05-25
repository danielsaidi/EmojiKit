//
//  Character+Emoji.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-01.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Character {

    /// Whether the character is a an emoji.
    ///
    /// This will manually add explicit checks for all later
    /// versions, since they don't support the unicode logic.
    var isEmoji: Bool {
        if isCombinedEmoji || isSimpleEmoji { return true }
        return isVersion15OrLaterEmoji
    }
    
    /// Whether the character is a multi-scalar emoji.
    var isCombinedEmoji: Bool {
        let scalars = unicodeScalars
        guard scalars.count > 1 else { return false }
        return scalars.first?.properties.isEmoji ?? false
    }
    
    /// Whether this character is an emoji that was released
    /// in version 15 or later.
    var isVersion15OrLaterEmoji: Bool {
        Self.version15PlusEmojiSet.contains(self)
    }

    private static let version15PlusEmojiSet: Set<Character> = {
        EmojiVersion.all
            .filter { $0.version >= 15 }
            .flatMap { $0.emojiString }
            .reduce(into: Set<Character>()) { $0.insert($1) }
    }()

    /// Whether the character is a one-scalar emoji.
    var isSimpleEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && scalar.value > 0x238C
    }
}
