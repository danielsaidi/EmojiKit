//
//  ScrollViewProxy+Grid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-01-08.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

@MainActor
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
    /// If `isArrowNavigation` is `true`, the proxy will try
    /// to scroll directly to the emoji, since we can assume
    /// that it's rendered out of bounds. Otherwise, we must
    /// first scroll to the category, since the emoji may be
    /// unavailable, after which we can try to scroll to the
    /// emoji after a delay. This may however still fail, if
    /// the emoji is too far out of bounds.
    func scrollToEmoji(
        _ emoji: Emoji,
        in category: EmojiCategory,
        anchor: UnitPoint = .top,
        isArrowNavigation: Bool = false
    ) {
        let emojiId = emoji.id(in: category)
        if isArrowNavigation {
            scrollTo(emojiId, anchor: anchor)
        } else {
            scrollToCategory(category, anchor: anchor)
            Task {
                try? await Task.sleep(for: .milliseconds(50))
                scrollTo(emojiId, anchor: anchor)
            }
        }
    }

    /// Scroll to a certain selection.
    ///
    /// If `isArrowNavigation` is `true`, the proxy will try
    /// to scroll directly to the emoji, since we can assume
    /// that it's rendered out of bounds. Otherwise, we must
    /// first scroll to the category, since the emoji may be
    /// unavailable, after which we can try to scroll to the
    /// emoji after a delay. This may however still fail, if
    /// the emoji is too far out of bounds.
    func scrollToSelection(
        _ selection: Emoji.GridSelection?,
        anchor: UnitPoint = .top,
        isArrowNavigation: Bool = false
    ) {
        guard
            let category = selection?.category,
            let emoji = selection?.emoji
        else { return }
        scrollToEmoji(
            emoji,
            in: category,
            anchor: anchor,
            isArrowNavigation: isArrowNavigation
        )
    }
}
