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
    /// > Note: For this to work, the emoji category must be
    /// visible. If not, first scroll to the category.
    func scrollToEmoji(
        _ emoji: Emoji,
        in category: EmojiCategory,
        anchor: UnitPoint = .top
    ) {
        scrollTo(emoji.id(in: category), anchor: anchor)
    }

    /// Scroll to a certain selection.
    ///
    /// > Note: For this to work, the emoji category must be
    /// visible. If not, first scroll to the category.
    func scrollToSelection(
        _ selection: Emoji.GridSelection?,
        anchor: UnitPoint = .top
    ) {
        guard
            let category = selection?.category,
            let emoji = selection?.emoji
        else { return }
        scrollToEmoji(emoji, in: category)
    }
}
