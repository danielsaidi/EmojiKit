//
//  ScrollViewProxy+Grid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-01-08.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension ScrollViewProxy {

    /// Calculate the number of items per emoji grid row.
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
    func scrollToSelection(
        _ selection: Emoji.GridSelection?
    ) {
        guard
            let category = selection?.category,
            let emoji = selection?.emoji
        else { return }
        scrollTo(emoji.id(in: category), anchor: .top)
    }
}
