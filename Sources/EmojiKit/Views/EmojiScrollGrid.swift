//
//  EmojiScrollGrid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-07.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This scroll grid wraps an ``EmojiGrid`` in a `ScrollView`
/// and will automatically scroll to the current `selection`.
///
/// The grid will either render a single list of emojis or a
/// list of emoji categories.
///
/// See the <doc:Views-Article> article for full information
/// on how to use these grids.
public struct EmojiScrollGrid<ItemView: View, SectionView: View>: View {
    
    /// Create an emoji scroll grid.
    ///
    /// If you provide a list of `emojis`, that list will be
    /// listed in the grid instead of the `categories`.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - emojis: A custom emoji collection to list, if any.
    ///   - categories: The categories to list, by default `.standard`.
    ///   - query: The search query to apply, if any.
    ///   - selection: The current grid selection, if any.
    ///   - persistedCategory: A persisted category to append to when picking an emoji, if any.
    ///   - geometryProxy: An optional geometry proxy, required to perform arrow/move-based navigation.
    ///   - action: An action to trigger when an emoji is tapped or picked, if any.
    ///   - categoryEmojis: An optional function that can determine which emojis to show for a certain category, by default all.
    ///   - section: A grid section title view builder.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        persistedCategory: EmojiCategory.PersistedCategory? = nil,
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionView,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> ItemView
    ) {
        let emojiCat = EmojiCategory.custom(id: "", name: "", emojis: emojis, iconName: "")
        let emojiCategories: [EmojiCategory]? = emojis.isEmpty ? nil : [emojiCat]
        let searchCategories: [EmojiCategory]? = query.isEmpty ? nil : [.search(query: query)]
        self.axis = axis
        self.emojis = emojis
        self.categories = searchCategories ?? emojiCategories ?? categories
        self.query = query
        self.persistedCategory = persistedCategory
        self.geometryProxy = geometryProxy
        self.action = action
        self.categoryEmojis = categoryEmojis
        self.section = section
        self.item = item
        self._selection = selection
    }

    private let axis: Axis.Set
    private let emojis: [Emoji]
    private let categories: [EmojiCategory]
    private let query: String
    private let persistedCategory: EmojiCategory.PersistedCategory?
    private let geometryProxy: GeometryProxy?
    private let action: (Emoji) -> Void
    private let categoryEmojis: (EmojiCategory) -> [Emoji]
    private let section: (Emoji.GridSectionParameters) -> SectionView
    private let item: (Emoji.GridItemParameters) -> ItemView

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
                        emojis: emojis,
                        categories: categories,
                        query: query,
                        selection: $selection,
                        persistedCategory: persistedCategory,
                        geometryProxy: geo,
                        action: action,
                        categoryEmojis: categoryEmojis,
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
                categoryEmojis: { Array($0.emojis.prefix(4)) },
                section: { $0.view },
                item: { $0.view }
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
