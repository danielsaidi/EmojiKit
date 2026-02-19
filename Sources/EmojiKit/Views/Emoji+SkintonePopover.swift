//
//  Emoji+SkintonePopover.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-12-14.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {

    /// This popover can be used to show skintone variations for any emoji.
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

        @Environment(\.emojiSkintonePopoverStyle) private var style

        @State private var hoverEmoji: Emoji?

        public var body: some View {
            HStack(spacing: 8) {
                button(for: emoji.neutralSkinToneVariant)
                let variants = emoji.skinToneVariants.dropFirst()
                if let dividerStyle = style.dividerStyle {
                    dividerStyle.color
                        .frame(width: dividerStyle.thickness)
                        .padding(.vertical, dividerStyle.verticalPadding)
                }
                ForEach(variants) {
                    button(for: $0)
                }
            }
            .padding(5)
            .popoverColorIfAvailable(style.backgroundColor)
            .popoverSizeIfAvailable()
        }
    }

    /// This style can be used to style a skintone popover.
    struct SkintonePopoverStyle {

        /// Create a skintone popover for the provided emoji.
        public init(
            backgroundColor: Color = .clear,
            dividerStyle: DividerStyle? = .standard
        ) {
            self.backgroundColor = backgroundColor
            self.dividerStyle = dividerStyle
        }

        public var backgroundColor: Color
        public var dividerStyle: DividerStyle?
    }

    /// This style can be used to style the divider within a skintone popover.
    struct DividerStyle {

        public init(
            color: Color = .secondary.opacity(0.25),
            thickness: CGFloat = 0.5,
            verticalPadding: CGFloat = 12
        ) {
            self.color = color
            self.thickness = thickness
            self.verticalPadding = verticalPadding
        }

        public var color: Color
        public var thickness: CGFloat
        public var verticalPadding: CGFloat
    }
}

public extension Emoji.SkintonePopoverStyle {

    static var standard: Self { .init() }
}

public extension Emoji.DividerStyle {

    static var standard: Self { .init() }
}

public extension EnvironmentValues {

    @Entry var emojiSkintonePopoverStyle: Emoji.SkintonePopoverStyle = .standard
}

public extension View {

    /// Apply an emoji skintone popover style.
    func emojiSkintonePopoverStyle(
        _ style: Emoji.SkintonePopoverStyle
    ) -> some View {
        self.environment(\.emojiSkintonePopoverStyle, style)
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
            .emojiSkintonePopoverStyle(.init(backgroundColor: .white, dividerStyle: .standard))
        }
    }

    return Preview()
}
