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
public struct EmojiScrollGrid<SectionTitle: View, GridItem: View>: View {
    
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
    ///   - geometryProxy: An optional geometry proxy, required to perform arrow/move-based navigation.
    ///   - action: An action to trigger when an emoji is tapped or picked, if any.
    ///   - categoryEmojis: An optional function that can determine which emojis to show for a certain category, by default all.
    ///   - sectionTitle: A grid section title view builder.
    ///   - gridItem: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder sectionTitle: @escaping (Emoji.GridSectionTitleParameters) -> SectionTitle,
        @ViewBuilder gridItem: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        let emojiCat = EmojiCategory.custom(id: "", name: "", emojis: emojis, iconName: "")
        let emojiCategories: [EmojiCategory]? = emojis.isEmpty ? nil : [emojiCat]
        let searchCategories: [EmojiCategory]? = query.isEmpty ? nil : [.search(query: query)]
        self.axis = axis
        self.emojis = emojis
        self.categories = searchCategories ?? emojiCategories ?? categories
        self.query = query
        self.geometryProxy = geometryProxy
        self.action = action
        self.categoryEmojis = categoryEmojis
        self.sectionTitle = sectionTitle
        self.gridItem = gridItem
        self._selection = selection
    }

    private let axis: Axis.Set
    private let emojis: [Emoji]
    private let categories: [EmojiCategory]
    private let query: String
    private let geometryProxy: GeometryProxy?
    private let action: (Emoji) -> Void
    private let categoryEmojis: (EmojiCategory) -> [Emoji]
    private let sectionTitle: (Emoji.GridSectionTitleParameters) -> SectionTitle
    private let gridItem: (Emoji.GridItemParameters) -> GridItem

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
                        geometryProxy: geo,
                        action: action,
                        categoryEmojis: categoryEmojis,
                        sectionTitle: sectionTitle,
                        gridItem: gridItem
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
        
        @State var query: String = ""
        
        @State var selection = Emoji.GridSelection(
            emoji: .init("😀"),
            category: .smileysAndPeople
        )
        
        var body: some View {
            VStack {
                TextField("Search", text: $query)
                    .padding(.horizontal, 3)
                
                Divider()
                
                ScrollViewReader { proxy in
                    EmojiScrollGrid(
                        axis: .vertical,
                        categories: [.recent] + .standard,
                        query: query,
                        selection: $selection,
                        categoryEmojis: { $0.emojis /*Array($0.emojis.prefix(4))*/ },
                        sectionTitle: { $0.view },
                        gridItem: { $0.view }
                    )
                    .emojiGridStyle(.small)
                    .onAppear {
                        proxy.scrollTo(selection)
                    }
                    .onChange(of: selection) { selection in
                        proxy.scrollTo(selection)
                    }
                }
            }
        }
    }
    
    return Preview()
}
