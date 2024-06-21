//
//  Emoji+SkintonePopover.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-12-14.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {

    /// This popover can be used to show skintone variations
    /// for any emoji.
    struct SkintonePopover: View {

        /// Create a skintone popover for the provided emoji.
        public init(
            emoji: Emoji,
            action: @escaping (Emoji) -> Void
        ) {
            self.emoji = emoji
            self.action = action
        }

        private let emoji: Emoji
        private let action: (Emoji) -> Void

        @State
        private var hoverEmoji: Emoji?

        public var body: some View {
            HStack {
                button(for: emoji.neutralSkinToneVariant)
                let variants = emoji.skinToneVariants.dropFirst()
                Divider().padding(5)
                ForEach(variants) {
                    button(for: $0)
                }
            }
            .padding(5)
            .popoverSizeIfAvailable()
        }
    }
}

private extension Emoji.SkintonePopover {

    func button(for emoji: Emoji) -> some View {
        Button {
            action(emoji)
        } label: {
            Text(emoji.char)
                #if os(iOS) || os(macOS)
                .onHover { hoverEmoji = $0 ? emoji : nil }
                #endif
        }
        .font(.largeTitle)
        #if os(iOS) || os(macOS)
        .buttonStyle(.borderless)
        #endif
        .padding(3)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(hoverEmoji == emoji ? Color.accentColor : .clear)
        )
    }
}

#Preview {

    struct Preview: View {

        let emoji = Emoji("👍")

        @State
        var isPopoverPresented = false

        var body: some View {
            Button {
                isPopoverPresented.toggle()
            } label: {
                Text(emoji.char)
            }
            .popoverIfAvailable($isPopoverPresented) {
                Emoji.SkintonePopover(
                    emoji: emoji,
                    action: { _ in isPopoverPresented.toggle() }
                )
            }
        }
    }

    return Preview()
}
