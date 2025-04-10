//
//  EmojiGridScrollView.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-07.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This grid can be used to list emojis or emoji categories
/// in a vertically or horizontally scrolling grid.
///
/// This grid can change the `selection` with the arrow keys,
/// and will trigger the provided `action` when any emoji is
/// selected by tapping or pressing return.
///
/// The `selection` will not update when the user selects an
/// emoji skin tone from the popup, since the original emoji
/// which opened the popover will not change. 
///
/// The grid automatically scrolls to the `selection` as the
/// selection changes. You can use ``EmojiGrid`` to render a
/// grid without scrolling capabilities.
///
/// See the <doc:Views-Article> article for full information
/// on how to use these grids.
public struct EmojiGridScrollView<SectionTitle: View, GridItem: View>: View {
    
    /// Create an emoji grid with a list of emojis.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - emojis: The emojis to list.
    ///   - query: The search query to apply, if any.
    ///   - selection: The current grid selection, if any.
    ///   - geometryProxy: An optional geometry proxy, required to perform arrow/move-based navigation.
    ///   - action: An action to trigger when an emoji is tapped or picked, if any.
    ///   - categoryEmojis: An optional function that can determine which emojis to show for a certain category, by default all.
    ///   - sectionTitle: A grid section title view builder.
    ///   - gridItem: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji],
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        geometryProxy: GeometryProxy? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping (Emoji.GridSectionTitleParameters) -> SectionTitle,
        @ViewBuilder gridItem: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.axis = axis
        self.emojis = emojis
        self.categories = nil
        self.query = query
        self.geometryProxy = geometryProxy
        self.action = action
        self.categoryEmojis = categoryEmojis
        self.sectionTitle = sectionTitle
        self.gridItem = gridItem
        self._selection = selection ?? .constant(.init())
    }
    
    /// Create an emoji grid with a list of emoji categories.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - categories: The categories to list, by default recent and standard.
    ///   - query: The search query to apply, if any.
    ///   - selection: The current grid selection, if any.
    ///   - geometryProxy: An optional geometry proxy, required to perform arrow/move-based navigation.
    ///   - action: An action to trigger when an emoji is tapped or picked, if any.
    ///   - categoryEmojis: An optional function that can determine which emojis to show for a certain category, by default all.
    ///   - sectionTitle: A grid section title view builder.
    ///   - gridItem: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        geometryProxy: GeometryProxy? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping (Emoji.GridSectionTitleParameters) -> SectionTitle,
        @ViewBuilder gridItem: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.axis = axis
        self.emojis = nil
        self.categories = categories
        self.query = query
        self.geometryProxy = geometryProxy
        self.action = action
        self.categoryEmojis = categoryEmojis
        self.sectionTitle = sectionTitle
        self.gridItem = gridItem
        self._selection = selection ?? .constant(.init())
    }

    private let axis: Axis.Set
    private let emojis: [Emoji]?
    private let categories: [EmojiCategory]?
    private let query: String?
    private let geometryProxy: GeometryProxy?
    private let action: ((Emoji) -> Void)?
    private let categoryEmojis: ((EmojiCategory) -> [Emoji])?
    private let sectionTitle: (Emoji.GridSectionTitleParameters) -> SectionTitle
    private let gridItem: (Emoji.GridItemParameters) -> GridItem

    @Binding var selection: Emoji.GridSelection
    
    @Environment(\.emojiGridStyle) var style
    
    public var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ScrollView(axis) {
                    if let emojis {
                        EmojiGrid(
                            axis: axis,
                            emojis: emojis,
                            query: query,
                            selection: $selection,
                            geometryProxy: geo,
                            action: action,
                            categoryEmojis: categoryEmojis,
                            sectionTitle: sectionTitle,
                            gridItem: gridItem
                        )
                    } else {
                        EmojiGrid(
                            axis: axis,
                            categories: categories,
                            query: query,
                            selection: $selection,
                            geometryProxy: geo,
                            action: action,
                            categoryEmojis: categoryEmojis,
                            sectionTitle: sectionTitle,
                            gridItem: gridItem
                        )
                    }
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
                    EmojiGridScrollView(
                        axis: .vertical,
                        // categories: [.recent] + .standard,
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
