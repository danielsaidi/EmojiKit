//
//  ScrollViewProxy+Grid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-01-08.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension ScrollViewProxy {

    /// Scroll to a certain emoji category.
    func scrollToCategory(
        _ category: EmojiCategory
    ) {
        scrollTo(category.id)
    }

    /// Scroll to a certain emoji category, provided that it
    /// exists in a certain category collection.
    func scrollToCategory(
        _ category: EmojiCategory?,
        in categories: [EmojiCategory]
    ) {
        guard let category else { return }
        let match = categories.first { $0.id == category.id }
        guard let match, let emoji = match.emojis.first else { return }
        scrollToSelection(.init(emoji: emoji, category: match))
    }

    /// Calculate the number of items per emoji grid row.
    func scrollToEmoji(
        _ category: EmojiCategory?,
        in categories: [EmojiCategory]
    ) {
        guard let category else { return }
        let match = categories.first { $0.id == category.id }
        guard let match, let emoji = match.emojis.first else { return }
        scrollToSelection(.init(emoji: emoji, category: match))
    }

    /// Calculate the number of items per emoji grid row.
    func scrollToSelection(
        _ selection: Emoji.GridSelection?,
        anchor: UnitPoint = .top
    ) {
        guard
            let category = selection?.category,
            let emoji = selection?.emoji
        else { return }
        scrollTo(emoji.id(in: category), anchor: anchor)
    }
}
