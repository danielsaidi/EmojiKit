//
//  Emoji+GridSelection.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-01-09.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {
    
    /// This struct can be used to handle grid selections.
    struct GridSelection: Equatable, Hashable {
        
        /// Create a grid selection value.
        ///
        /// If you don't provide a selected emoji, the first
        /// emoji in the first category will be used.
        ///
        /// The initializer will return `nil` if no matching
        /// emoji is found in the category.
        public init(
            emoji: Emoji? = nil,
            category: EmojiCategory? = nil
        ) {
            let emoji = emoji ?? category?.emojis.first
            self.category = category
            self.emoji = emoji
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
        category: EmojiCategory? = nil
    ) -> Bool {
        self.emoji == emoji && self.category == category
    }

    /// Whether a certain emoji is selected.
    func isSelected(
        emoji: Emoji?,
        in category: EmojiCategory? = nil
    ) -> Bool {
        self.emoji == emoji && self.category == category
    }

    /// Reset the current selection.
    mutating func reset() {
        self.emoji = nil
        self.category = nil
    }

    /// Select a certain emoji in a certain category.
    mutating func select(
        emoji: Emoji?,
        in category: EmojiCategory?
    ) {
        self.emoji = emoji
        self.category = category
    }
}
