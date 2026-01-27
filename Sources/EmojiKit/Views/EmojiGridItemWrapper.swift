//
//  EmojiGridItemWrapper.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-21.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This internal view is used to apply additional modifiers
/// to a grid item, to avoid redrawing the entire grid.
struct EmojiGridItemWrapper<ItemView: View>: View {

    let emoji: Emoji
    let category: EmojiCategory
    let action: (Emoji, EmojiCategory) -> Void

    @Binding var popoverSelection: Emoji.GridSelection?

    @ViewBuilder let content: () -> ItemView

    @State private var isPopoverPresented = false

    var body: some View {
        if #available(iOS 16.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            content()
                .onChange(of: isPopoverPresented) { isPresented in
                    if isPresented { return }
                    popoverSelection = nil
                }
                .onChange(of: popoverSelection) { _ in
                    isPopoverPresented = hasSkinToneVariants && isSelected
                }
                #if os(iOS) || os(macOS)
                .popover(isPresented: $isPopoverPresented) {
                    Emoji.SkintonePopover(emoji: emoji) { emoji in
                        action(emoji, category)
                        isPopoverPresented = false
                    }
                }
                #endif
        } else {
            content()
        }
    }

    private var hasSkinToneVariants: Bool {
        emoji.hasSkinToneVariants
    }

    private var isSelected: Bool {
        popoverSelection?.matches(
            emoji: emoji,
            category: category
        ) ?? false
    }
}
