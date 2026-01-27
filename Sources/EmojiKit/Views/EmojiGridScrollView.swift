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
/// This view will automatically scroll to a new `selection`.
///
/// This grid can change the `selection` with the arrow keys
/// and triggers an `action` when any emoji is selected. The
/// `selection` will not update when selecting an emoji skin
/// tone from the popover.
///
/// The optional `visibleCategoryId` binding will be updated
/// when a category title is displayed, but only for iOS 18+
/// and aligned versions. You can observe this value to show
/// the current category, and set it to scroll to a category
/// without selecting.
///
/// See <doc:Views-Article> for more information about grids.
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
    ///   - selection: An grid selection binging, if any.
    ///   - visibleCategoryId: The currently visible category, if any.
    ///   - addSelectedEmojiTo: The categories to update on selection, by default `frequent` and `recent`.
    ///   - action: An action to trigger when an emoji is selected, if any.
    ///   - categoryEmojis: An optional function that can customize emojis for a category.
    ///   - sectionTitle: A grid section title view builder.
    ///   - gridItem: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory]? = nil,
        emojis: [Emoji]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection?>? = nil,
        visibleCategoryId: Binding<EmojiCategory.ID?>? = nil,
        addSelectedEmojiTo: [EmojiCategory.Persisted]? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping SectionTitleBuilder,
        @ViewBuilder gridItem: @escaping GridItemBuilder
    ) {
        let categories = categories ?? .standardGrid
        self.axis = axis
        self.emojis = emojis
        self.categories = categories.adjustedForGrid(leadingEmojis: emojis, query: query)
        self.query = query
        self._selection = selection ?? .constant(nil)
        self._visibleCategoryId =  visibleCategoryId ?? .constant(nil)
        self.addSelectedEmojiTo = addSelectedEmojiTo
        self.action = action
        self.categoryEmojis = categoryEmojis
        self.sectionTitle = sectionTitle
        self.gridItem = gridItem
    }

    @Binding var selection: Emoji.GridSelection?
    @Binding var visibleCategoryId: EmojiCategory.ID?

    private let axis: Axis.Set
    private let emojis: [Emoji]?
    private let categories: [EmojiCategory]?
    private let query: String?
    private let addSelectedEmojiTo: [EmojiCategory.Persisted]?
    private let action: ((Emoji) -> Void)?
    private let categoryEmojis: ((EmojiCategory) -> [Emoji])?
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
            Text(visibleCategoryId ?? "-")
            EmojiGrid(
                axis: axis,
                categories: categories,
                emojis: emojis,
                query: query,
                selection: $selection,
                visibleCategoryId: $visibleCategoryId,
                addSelectedEmojiTo: addSelectedEmojiTo,
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
                scroll.scrollTo(selection)
            }
        }
        .onChange(of: selection) {
            scroll.scrollTo($0)
        }
        .onChange(of: visibleCategoryId) { newValue in
            guard isCategorySyncEnabled else { return }
            let category = categories?.first { $0.id == newValue }
            guard category != selection?.category else { return }
            let emoji = category?.emojis.first
            guard let category, let emoji else { return }
            let selection = Emoji.GridSelection(emoji: emoji, category: category)
            scroll.scrollTo(selection)
        }
    }
}

#Preview {
    
    struct Preview: View {
        
        @State var query: String = ""
        @State var visibleCategoryId: EmojiCategory.ID?
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
                            query: query,
                            selection: $selection,
                            visibleCategoryId: $visibleCategoryId,
                            sectionTitle: { $0.view },
                            gridItem: { $0.view }
                        )
                        .emojiGridStyle(.small)
                    }
                }
                .navigationTitle(visibleCategoryId ?? "Preview")
                .toolbar {
                    Button("Select") {
                        withAnimation {
                            //selection = .init(emoji: "😀", category: .smileysAndPeople)
                            visibleCategoryId = EmojiCategory.flags.id
                        }
                    }
                }
            }
        }
    }
    
    return Preview()
}
