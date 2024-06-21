//
//  EmojiScrollGrid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-07.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This scroll grid wraps an ``EmojiGrid`` in a `ScrollView`
/// and automatically scrolls to the current `selection`.
///
/// See the ``EmojiGrid`` for more information on how to use,
/// customize, and style this grid.
///
/// > Important: When emojis are listed in category sections,
/// you must use ``Emoji/id(in:)`` to scroll to an emoji.
public struct EmojiScrollGrid<ItemView: View, SectionView: View>: View {
    
    /// Create an emoji grid with multiple category sections.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - categories: The categories to list, by default `.all`.
    ///   - selection: The current grid selection, if any.
    ///   - frequentEmojiProvider: The ``FrequentEmojiProvider`` to use, by default a ``MostRecentEmojiProvider``.
    ///   - action: An action to trigger when an emoji is tapped or picked.
    ///   - section: A grid section title view builder.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory] = .all,
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        frequentEmojiProvider: (any FrequentEmojiProvider)? = MostRecentEmojiProvider(),
        action: @escaping EmojiAction = { _ in },
        @ViewBuilder section: @escaping SectionViewBuilder,
        @ViewBuilder item: @escaping ItemViewBuilder
    ) {
        self.categories = categories
        self.axis = axis
        self.frequentEmojiProvider = frequentEmojiProvider
        self.action = action
        self.section = section
        self.item = item
        self._selection = selection
    }
    
    /// Create an emoji grid with a single section.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - emojis: The emojis to list.
    ///   - selection: The current grid selection, if any.
    ///   - frequentEmojiProvider: The ``FrequentEmojiProvider`` to use, if any.
    ///   - action: An action to trigger when an emoji is tapped or picked.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji],
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        frequentEmojiProvider: (any FrequentEmojiProvider)? = MostRecentEmojiProvider(),
        action: @escaping EmojiAction = { _ in },
        @ViewBuilder item: @escaping ItemViewBuilder
    ) where SectionView == Emoji.GridSectionTitle {
        let chars = emojis.map { $0.char }.joined()
        self.categories = [.custom(id: "", name: "", emojis: chars, iconName: "")]
        self.axis = axis
        self.frequentEmojiProvider = frequentEmojiProvider
        self.action = action
        self.section = { $0.view }
        self.item = item
        self._selection = selection
    }
    
    public typealias EmojiAction = (Emoji) -> Void
    public typealias ItemViewBuilder = (Emoji.GridItemParameters) -> ItemView
    public typealias SectionViewBuilder = (Emoji.GridSectionParameters) -> SectionView
    
    private let categories: [EmojiCategory]
    private let axis: Axis.Set
    private let frequentEmojiProvider: (any FrequentEmojiProvider)?
    private let action: EmojiAction
    private let section: SectionViewBuilder
    private let item: ItemViewBuilder
    
    @Binding
    private var selection: Emoji.GridSelection
    
    @Environment(\.emojiGridStyle)
    private var style
    
    public var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ScrollView(axis) {
                    EmojiGrid(
                        axis: axis,
                        categories: categories,
                        selection: $selection,
                        frequentEmojiProvider: frequentEmojiProvider,
                        geometryProxy: geo,
                        action: action,
                        section: section,
                        item: item
                    )
                    .padding(style.padding)
                }
                .onAppear {
                    Task {
                        try await Task.sleep(nanoseconds: 100_000_000)
                        proxy.scrollTo(selection)
                    }
                }
                .onChange(of: selection) {
                    proxy.scrollTo($0)
                }
            }
        }
    }
}

#Preview {
    
    struct Preview: View {
        
        @State
        var selection = Emoji.GridSelection()
        
        func grid(
            _ axis: Axis.Set
        ) -> some View {
            EmojiScrollGrid(
                axis: axis,
                selection: $selection,
                // frequentEmojiProvider: provider,
                section: { $0.view },
                item: { params in
                    Button {
                        select(params.emoji, cat: params.category)
                    } label: {
                        params.view
                    }
                    .buttonStyle(EmojiGridPreviewButtonStyle())
                }
            )
        }
        
        func select(
            _ emoji: Emoji,
            cat: EmojiCategory
        ) {
            selection = .init(emoji: emoji, category: cat)
        }
        
        var body: some View {
            VStack(spacing: 0) {
                grid(.vertical)
                Divider()
                grid(.horizontal)
            }
        }
    }
    
    return Preview()
        // .emojiGridStyle(.extraLarge)
}
