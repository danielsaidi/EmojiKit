//
//  Emoji+GridSelection.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-01-09.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {
    
    /// This struct can be used to handle grid selections.
    ///
    /// `TODO` Make the emoji and category non-optional when
    /// bumping to 3.0.
    struct GridSelection: Codable, Equatable, Hashable {
        
        /// Create a grid selection value.
        ///
        /// If you don't provide an emoji, the first emoji will be used.
        public init(
            emoji: Emoji? = nil,
            category: EmojiCategory? = nil
        ) {
            let emoji = emoji ?? category?.emojis.first
            self.category = category
            self.emoji = emoji
        }

        public init(
            emoji: String,
            category: EmojiCategory
        ) {
            self.init(
                emoji: Emoji(emoji),
                category: category
            )
        }

        /// The currently selected emoji.
        public var emoji: Emoji?

        /// The currently selected category.
        public var category: EmojiCategory?
    }
}

public extension Emoji.GridSelection {

    /// Whether the selection has a current selection.
    var hasSelection: Bool {
        !isEmpty
    }

    /// Whether the selection has no current selection.
    var isEmpty: Bool {
        emoji == nil && category == nil
    }

    /// Whether or not the selection matches the parameters.
    func matches(
        emoji: Emoji?,
        category: EmojiCategory
    ) -> Bool {
        self.emoji == emoji && self.category == category
    }

    /// Whether a certain emoji and category is selected.
    func isSelected(
        emoji: Emoji?,
        in category: EmojiCategory
    ) -> Bool {
        self.emoji == emoji && self.category == category
    }

    @available(*, deprecated, message: "This is no longer used.")
    mutating func reset() {
        self.emoji = nil
        self.category = nil
    }

    @available(*, deprecated, message: "This is no longer used.")
    mutating func select(
        emoji: Emoji?,
        in category: EmojiCategory?
    ) {
        self.emoji = emoji
        self.category = category
    }
}
