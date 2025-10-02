//
//  EmojiGridItemWrapper.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-21.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This internal view is used to apply additional modifiers to the emoji grid item.
struct EmojiGridItemWrapper<ItemView: View>: View {

    let params: Emoji.GridItemParameters
    let action: (Emoji, EmojiCategory) -> Void

    @Binding 
    var popoverSelection: Emoji.GridSelection?

    @ViewBuilder 
    let content: () -> ItemView

    @State
    private var isPopoverPresented = false

    var body: some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            content()
                .onChange(of: isPopoverPresented) { isPresented in
                    if isPresented { return }
                    popoverSelection = nil
                }
                .onChange(of: popoverSelection) {
                    isPopoverPresented = hasSkinToneVariants && isSelected
                }
                #if os(iOS) || os(macOS)
                .popover(isPresented: $isPopoverPresented) {
                    Emoji.SkintonePopover(emoji: params.emoji) { emoji in
                        action(emoji, params.category)
                        isPopoverPresented = false
                    }
                }
                #endif
        } else {
            content()
        }
    }

    private var hasSkinToneVariants: Bool {
        params.emoji.hasSkinToneVariants
    }

    private var isSelected: Bool {
        popoverSelection?.matches(emoji: params.emoji, category: params.category) ?? false
    }
}
