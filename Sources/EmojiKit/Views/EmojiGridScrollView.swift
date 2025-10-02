//
//  EmojiGridScrollView.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-07.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This grid can be used to list emojis or categories in a vertical or horizontal grid.
///
/// This grid can change the `selection` with the arrow keys, and will trigger a
/// provided `action` when any emoji is selected by tapping or pressing return.
///
/// The `selection` will not update if the user selects an emoji skin tone from
/// a popup, since the original emoji that opened the popover will not change.
///
/// This view renders a scrolling grid thatautomatically scrolls to the `selection`.
/// Use ``EmojiGridView`` to render a plain, non- scrolling grid view.
///
/// See the <doc:Views-Article> article for information on how to use grids.
public struct EmojiGridScrollView<SectionTitle: View, GridItem: View>: View {
    
    /// Create an emoji grid with a list of emoji categories.
    ///
    /// If you provide a custom `emojis` list, the list will
    /// be converted to a category and placed firstmost.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - categories: The categories to list, by default frequent and standard.
    ///   - emojis: A custom list of emojis to add firstmost, if any.
    ///   - query: The search query to apply, if any.
    ///   - selection: An external binding for the grid's current selection, if any.
    ///   - registerSelectionFor: The categories to update on selection, by default `frequent`.
    ///   - action: An action to trigger when an emoji is selected, if any.
    ///   - categoryEmojis: An optional function that can customize emojis for a category.
    ///   - sectionTitle: A grid section title view builder.
    ///   - gridItem: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory]? = nil,
        emojis: [Emoji]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        registerSelectionFor: [EmojiCategory.Persisted]? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping (Emoji.GridSectionTitleParameters) -> SectionTitle,
        @ViewBuilder gridItem: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.axis = axis
        self.emojis = nil
        self.categories = categories
        self.query = query
        self._selection = selection ?? .constant(.init())
        self.registerSelectionFor = registerSelectionFor
        self.action = action
        self.categoryEmojis = categoryEmojis
        self.sectionTitle = sectionTitle
        self.gridItem = gridItem
    }

    private let axis: Axis.Set
    private let emojis: [Emoji]?
    private let categories: [EmojiCategory]?
    private let query: String?
    private let registerSelectionFor: [EmojiCategory.Persisted]?
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
                    EmojiGrid(
                        axis: axis,
                        categories: categories,
                        emojis: emojis,
                        query: query,
                        selection: $selection,
                        registerSelectionFor: registerSelectionFor,
                        geometryProxy: geo,
                        action: action,
                        categoryEmojis: categoryEmojis,
                        sectionTitle: sectionTitle,
                        gridItem: gridItem
                    )
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
