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
struct EmojiGridItemWrapper<Content: View>: View {

    let emoji: Emoji
    let category: EmojiCategory
    let action: (Emoji, EmojiCategory) -> Void

    @Binding var popoverSelection: Emoji.GridSelection?

    @ViewBuilder let content: () -> Content

    @State private var isPopoverPresented = false

    var body: some View {
        content()
            .onChange(of: isPopoverPresented) { isPresented in
                if isPresented { return }
                popoverSelection = nil
            }
            .onChange(of: popoverSelection) { newValue in
                let shouldPresent = emoji.hasSkinToneVariants
                    && (newValue?.matches(emoji: emoji, category: category) ?? false)
                if isPopoverPresented != shouldPresent {
                    isPopoverPresented = shouldPresent
                }
            }
            #if os(iOS) || os(macOS)
            .popover(isPresented: $isPopoverPresented) {
                Emoji.SkintonePopover(emoji: emoji) { emoji in
                    action(emoji, category)
                    isPopoverPresented = false
                }
            }
            #endif
    }
}
