//
//  FrequentEmojiProvider.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// used to get a list of frequently used emojis.
///
/// Call ``registerEmoji(_:)`` whenever an emoji is used, to
/// register the emoji and update the provider.
public protocol FrequentEmojiProvider {
    
    /// A list of frequently used emojis.
    var emojis: [Emoji] { get }
    
    /// Register that an emoji has been used.
    func registerEmoji(_ emoji: Emoji)
    
    /// Reset the underlying data source.
    func reset()
}
