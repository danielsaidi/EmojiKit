//
//  EmojiScrollGrid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-07.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view wraps an ``EmojiGrid`` in a scroll view.
///
/// This view automatically scrolls to its current selection,
/// both when it's loaded and whenever the selection changes.
///
/// See the ``EmojiGrid`` for more information on how to use,
/// customize, and style the grid.
public struct EmojiScrollGrid<ItemView: View, SectionView: View>: View {
    
    /// Create an emoji grid with multiple category sections.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - categories: The categories to list, by default `.all`.
    ///   - selection: The current grid selection, if any.
    ///   - frequentEmojiProvider: The ``FrequentEmojiProvider`` to use, by default a ``MostRecentEmojiProvider``.
    ///   - section: A grid section title view builder.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory] = .all,
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        frequentEmojiProvider: (any FrequentEmojiProvider)? = MostRecentEmojiProvider(),
        @ViewBuilder section: @escaping SectionViewBuilder,
        @ViewBuilder item: @escaping ItemViewBuilder
    ) {
        self.categories = categories
        self.axis = axis
        self.frequentEmojiProvider = frequentEmojiProvider
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
    ///   - section: A grid section title view builder.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji],
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        frequentEmojiProvider: (any FrequentEmojiProvider)? = MostRecentEmojiProvider(),
        @ViewBuilder section: @escaping SectionViewBuilder,
        @ViewBuilder item: @escaping ItemViewBuilder
    ) {
        let chars = emojis.map { $0.char }.joined()
        self.categories = [.custom(id: "", name: "", emojis: chars, iconName: "")]
        self.axis = axis
        self.frequentEmojiProvider = frequentEmojiProvider
        self.section = section
        self.item = item
        self._selection = selection
    }
    
    public typealias ItemViewBuilder = (Emoji.GridItemParameters) -> ItemView
    public typealias SectionViewBuilder = (Emoji.GridSectionParameters) -> SectionView
    
    private let categories: [EmojiCategory]
    private let axis: Axis.Set
    private let frequentEmojiProvider: (any FrequentEmojiProvider)?
    private let section: SectionViewBuilder
    private let item: ItemViewBuilder
    
    @Binding
    private var selection: Emoji.GridSelection
    
    @Environment(\.emojiGridStyle)
    private var style
    
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(axis) {
                EmojiGrid(
                    axis: axis,
                    categories: categories,
                    selection: $selection,
                    frequentEmojiProvider: frequentEmojiProvider,
                    section: section,
                    item: item
                )
                .padding(5)
            }
            .onAppear {
                proxy.scrollTo(selection)
            }
            .onChange(of: selection) {
                proxy.scrollTo($0)
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
