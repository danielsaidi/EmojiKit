//
//  EmojiGridScrollView.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-07.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This grid can be used to list emojis and categories in a
/// scrolling vertical or horizontal grid.
///
/// This grid can change `selection` with the arrow keys and
/// trigger an `action` when emojis are selected with return
/// or by tapping an emoji. Note that some bindings only has
/// a visible effect on iOS 18+ and aligned versions.
///
/// > Important: Note that the `selection` changing does NOT
/// mean that the user has *picked* the emoji. The selection
/// will for instance change when navigating using the arrow
/// keys and the action is then only triggered when pressing
/// the return key on an emoji.
///
/// See <doc:Views-Article> for more information about grids.
public struct EmojiGridScrollView<SectionTitle: View, GridItem: View>: View {
    
    /// Create a emoji grid scroll view.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - categories: The categories to list, by default `.standardGrid`.
    ///   - category: The currently visible category, if any.
    ///   - selection: An grid selection binging, if any.
    ///   - query: The search query to apply, if any.
    ///   - addSelectedEmojisTo: The categories add selected emojis to, by default `frequent` and `recent`.
    ///   - action: An action to trigger when an emoji is selected, if any.
    ///   - sectionTitle: A grid section title view builder.
    ///   - gridItem: A grid item view builder.
    public init(
        axis: Axis.Set? = nil,
        categories: [EmojiCategory]? = nil,
        category: Binding<EmojiCategory?>,
        selection: Binding<Emoji.GridSelection?>,
        query: String? = nil,
        addSelectedEmojisTo: [EmojiCategory.Persisted]? = nil,
        action: ((Emoji) -> Void)? = nil,
        @ViewBuilder sectionTitle: @escaping SectionTitleBuilder,
        @ViewBuilder gridItem: @escaping GridItemBuilder
    ) {
        self.axis = axis ?? .vertical
        self.categories = categories ?? .standardGrid
        self._category = category
        self._selection = selection
        self.query = query
        self.addSelectedEmojisTo = addSelectedEmojisTo
        self.action = action
        self.sectionTitle = sectionTitle
        self.gridItem = gridItem
    }

    @Binding var category: EmojiCategory?
    @Binding var selection: Emoji.GridSelection?

    private let axis: Axis.Set
    private let categories: [EmojiCategory]
    private let query: String?
    private let addSelectedEmojisTo: [EmojiCategory.Persisted]?
    private let action: ((Emoji) -> Void)?

    private let sectionTitle: (Emoji.GridSectionTitleParameters) -> SectionTitle
    private let gridItem: (Emoji.GridItemParameters) -> GridItem

    public typealias SectionTitleBuilder = (Emoji.GridSectionTitleParameters) -> SectionTitle
    public typealias GridItemBuilder = (Emoji.GridItemParameters) -> GridItem

    public var body: some View {
        GeometryReader { geo in
            ScrollViewReader { scroll in
                ScrollView(axis) {
                    EmojiGrid(
                        axis: axis,
                        categories: categories,
                        category: $category,
                        selection: $selection,
                        query: query,
                        addSelectedEmojisTo: addSelectedEmojisTo,
                        geometryProxy: geo,
                        scrollViewProxy: scroll,
                        action: action,
                        sectionTitle: sectionTitle,
                        gridItem: gridItem
                    )
                }
            }
        }
    }
}

#Preview {

    struct Preview: View {

        @State var category: EmojiCategory?
        @State var query: String = ""
        @State var selection: Emoji.GridSelection?

        var body: some View {
            NavigationStack {
                EmojiGridScrollView(
                    axis: .vertical,
                    categories: .standardGrid,
                    category: $category,
                    selection: $selection,
                    query: query,
                    action: { print($0) },
                    sectionTitle: { $0.view },
                    gridItem: { $0.view }
                )
                .navigationTitle(category?.localizedName ?? "EmojiPicker")
                .toolbar {
                    Button("Select") {
                        category = EmojiCategory.flags
                    }
                }
            }
        }
    }

    return Preview()
}

