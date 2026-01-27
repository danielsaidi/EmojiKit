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
/// See <doc:Views-Article> for more information about grids.
public struct EmojiGridScrollView<SectionTitle: View, GridItem: View>: View {
    
    /// Create an emoji grid.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - categories: The categories to list, by default `.standardGrid`.
    ///   - category: The currently visible category, if any.
    ///   - selection: An grid selection binging, if any.
    ///   - query: The search query to apply, if any.
    ///   - addSelectedEmojisTo: The categories to update on selection, by default `frequent` and `recent`.
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

    @Environment(\.emojiGridStyle) var style

    @State private var isCategorySyncEnabled: Bool = false

    public var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                bodyView(for: geo, scroll: proxy)
            }
        }
    }

    @ViewBuilder
    private func bodyView(
        for geo: GeometryProxy,
        scroll: ScrollViewProxy
    ) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            scrollView(for: geo, scroll: scroll)
                .onAppear {
                    isCategorySyncEnabled = true
                }
                .onScrollPhaseChange { oldPhase, newPhase in
                    isCategorySyncEnabled = !newPhase.isScrolling
                }
        } else {
            scrollView(for: geo, scroll: scroll)
        }
    }

    private func scrollView(
        for geo: GeometryProxy,
        scroll: ScrollViewProxy
    ) -> some View {
        ScrollView(axis) {
            EmojiGrid(
                axis: axis,
                categories: categories,
                category: $category,
                selection: $selection,
                query: query,
                addSelectedEmojisTo: addSelectedEmojisTo,
                geometryProxy: geo,
                action: action,
                sectionTitle: sectionTitle,
                gridItem: gridItem
            )
        }
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 100_000_000)
                scroll.scrollToSelection(selection)
            }
        }
        .onChange(of: selection) {
            scroll.scrollToSelection($0)
        }
        .onChange(of: category) {
            guard isCategorySyncEnabled else { return }
            guard $0 != selection?.category else { return }
            scroll.scrollToCategory($0, in: categories)
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
                VStack(spacing: 0) {
                    TextField("Search", text: $query)
                        .padding(.horizontal, 3)

                    Divider()

                    ScrollViewReader { proxy in
                        EmojiGridScrollView(
                            axis: .vertical,
                            // categories: [.recent] + .standard,
                            category: $category,
                            selection: $selection,
                            query: query,
                            sectionTitle: { $0.view },
                            gridItem: { $0.view }
                        )
                        .emojiGridStyle(.small)
                    }
                }
                .navigationTitle(category?.localizedName ?? "Preview")
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
