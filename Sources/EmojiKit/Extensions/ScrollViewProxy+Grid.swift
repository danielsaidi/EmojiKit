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
        _ category: EmojiCategory?,
        anchor: UnitPoint = .top
    ) {
        guard let category else { return }
        scrollTo(category.id, anchor: anchor)
    }

    /// Scroll to a certain emoji in a certain category.
    ///
    /// > Note: This will not work reliably, since the emoji
    /// must be rendered for scrolling to work.
    func scrollToEmoji(
        _ emoji: Emoji?,
        in category: EmojiCategory?,
        anchor: UnitPoint = .top
    ) {
        guard let emoji, let category else { return }
        scrollToSelection(
            .init(emoji: emoji, category: category),
            anchor: anchor
        )
    }

    /// Scroll to a certain selection.
    ///
    /// > Note: This will not work reliably, since the emoji
    /// must be rendered for scrolling to work.
    func scrollToSelection(
        _ selection: Emoji.GridSelection?,
        anchor: UnitPoint = .top
    ) {
        guard
            let category = selection?.category,
            let emoji = selection?.emoji
        else { return }
        let scrollId = emoji.id(in: category)
        scrollTo(scrollId, anchor: anchor)
    }
}
