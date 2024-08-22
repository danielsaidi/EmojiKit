//
//  EmojiGrid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-02.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used to list emojis in a grid.
///
/// You can use an ``EmojiScrollGrid`` to wrap the grid in a
/// `ScrollView` that auto-scrolls to any new selections and
/// that automatically enables arrow-key selections.
///
/// See the <doc:Views-Article> article for full information
/// on how to use these grids.
public struct EmojiGrid<ItemView: View, SectionView: View>: View {
    
    /// Create an emoji grid.
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
    ///   - frequentEmojiProvider: The ``EmojiProvider`` to use, by default a ``EmojiProviders/MostRecentProvider``.
    ///   - geometryProxy: An optional geometry proxy, required to perform arrow/move-based navigation.
    ///   - action: An action to trigger when an emoji is tapped or picked.
    ///   - section: A grid section title view builder.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        frequentEmojiProvider: (any EmojiProvider)? = EmojiProviders.MostRecentProvider(),
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionView,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> ItemView
    ) {
        let emojiCat = EmojiCategory.custom(id: "", name: "", emojis: emojis, iconName: "")
        let emojiCategories: [EmojiCategory]? = emojis.isEmpty ? nil : [emojiCat]
        let searchCategories: [EmojiCategory]? = query.isEmpty ? nil : [.search(query: query)]
        self.axis = axis
        self.categories = searchCategories ?? emojiCategories ?? categories
        self.query = query
        self.frequentEmojiProvider = frequentEmojiProvider
        self.geometryProxy = geometryProxy
        self.action = action
        self.section = section
        self.item = item
        self._selection = selection
    }
    
    private let axis: Axis.Set
    private let categories: [EmojiCategory]
    private let query: String
    private let frequentEmojiProvider: (any EmojiProvider)?
    private let geometryProxy: GeometryProxy?
    private let action: (Emoji) -> Void
    private let section: (Emoji.GridSectionParameters) -> SectionView
    private let item: (Emoji.GridItemParameters) -> ItemView

    @Binding
    private var selection: Emoji.GridSelection

    @Environment(\.emojiGridStyle)
    private var style

    @Environment(\.layoutDirection)
    private var layoutDirection

    @State
    private var popoverSelection: Emoji.GridSelection?

    public var body: some View {
        bodyContent.id(query)
    }

    @ViewBuilder
    private var bodyContent: some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            grid
                .focusable(true)
                .focusEffectDisabled(!style.prefersFocusEffect)
                #if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)
                .onKeyPress {
                    var result: Bool
                    switch $0.key {
                    case .downArrow: result = handleDirection(.down)
                    case .leftArrow: result = handleDirection(.left)
                    case .escape: result = handleEscape()
                    case .return: result = handleReturn($0)
                    case .rightArrow: result = handleDirection(.right)
                    case .upArrow: result = handleDirection(.up)
                    default: result = false
                    }
                    return result ? .handled : .ignored
                }
                #endif
                #if os(tvOS)
                .onMoveCommand(perform: selectEmoji)
                #endif
                .padding(style.padding)
        } else {
            grid
                .padding(style.padding)
        }
    }
}

private extension EmojiGrid {

    func handleDirection(_ direction: Emoji.GridDirection) -> Bool {
        selectEmoji(with: direction)
        return true
    }

    func handleEscape() -> Bool {
        selection.reset()
        return true
    }

    #if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, *)
    func handleReturn(_ press: SwiftUI.KeyPress) -> Bool {
        if press.modifiers.isEmpty { return pickSelectedEmoji() }
        if press.modifiers == .option { return showPopoverForSelection() }
        return false
    }
    #endif

    func pickEmoji(_ emoji: Emoji) {
        frequentEmojiProvider?.addEmoji(emoji)
        action(emoji)
    }

    func pickSelectedEmoji() -> Bool {
        guard let emoji = selection.emoji else { return false }
        pickEmoji(emoji)
        return true
    }

    func selectEmoji(
        _ emoji: Emoji,
        in category: EmojiCategory,
        pick: Bool = false,
        skintonePopover: Bool = false
    ) {
        selection = .init(emoji: emoji, category: category)
        if pick { _ = pickSelectedEmoji() }
        if skintonePopover { popoverSelection = selection }
    }

    #if os(macOS) || os(tvOS)
    func selectEmoji(
        with direction: MoveCommandDirection
    ) {
        selectEmoji(with: direction.emojiGridDirection)
    }
    #endif

    func selectEmoji(
        with direction: Emoji.GridDirection
    ) {
        guard let geo = geometryProxy else { return }
        let layoutDirection = direction.transform(for: layoutDirection)
        let navDirection = layoutDirection.navigationDirection(for: axis)
        if selection.isEmpty { return selectFirstCategory() }
        guard
            let category = selection.category,
            let emoji = selection.emoji
        else { return }

        let emojis = emojis(for: category)
        guard
            let index = emojis.firstIndex(of: emoji)
        else { return }

        let itemsPerRow = geo.itemsPerRow(
            for: axis,
            style: style
        )

        let newIndex = layoutDirection.destinationIndex(
            for: axis,
            currentIndex: index,
            itemsPerRow: itemsPerRow
        )

        if let emoji = emojis.emoji(at: newIndex) {
            selectEmoji(emoji, in: category)
        } else if navDirection == .back {
            guard
                let cat = categories.category(before: category),
                let emoji = self.emojis(for: cat).last
            else { return }
            selectEmoji(emoji, in: cat)
        } else {
            guard
                let cat = categories.category(after: category),
                let emoji = self.emojis(for: cat).first
            else { return }
            selectEmoji(emoji, in: cat)
        }
    }

    func selectFirstCategory() {
        let firstNonEmpty = categories.first { !emojis(for: $0).isEmpty }
        guard let category = firstNonEmpty else { return }
        let emoji = emojis(for: category).first
        selection.select(emoji: emoji, in: category)
    }

    func showPopoverForSelection() -> Bool {
        popoverSelection = selection
        return true
    }
}

private extension EmojiGrid {

    @ViewBuilder
    var grid: some View {
        if axis == .horizontal {
            LazyHGrid(
                rows: style.items,
                alignment: .top,
                spacing: style.itemSpacing,
                content: gridContent
            )
        } else {
            LazyVGrid(
                columns: style.items,
                alignment: .leading,
                spacing: style.itemSpacing,
                content: gridContent
            )
        }
    }
    
    func gridContent() -> some View {
        ForEach(categories) { category in
            if hasEmojis(for: category) {
                Section {
                    gridContent(for: category)
                } header: {
                    gridTitle(for: category)
                }
            }
        }
    }
    
    @ViewBuilder
    func gridContent(
        for category: EmojiCategory
    ) -> some View {
        let emojis = emojis(for: category)
        ForEach(Array(emojis.enumerated()), id: \.offset) {
            gridContent(for: category, emoji: $0.element, offset: $0.offset)
        }
    }

    @ViewBuilder
    func gridContent(
        for category: EmojiCategory,
        emoji: Emoji,
        offset: Int
    ) -> some View {
        let params = Emoji.GridItemParameters(
            emoji: emoji,
            category: category,
            categoryIndex: offset,
            isSelected: isSelected(emoji, in: category),
            view: Emoji.GridItem(
                emoji,
                isSelected: isSelected(emoji, in: category)
            )
        )
        EmojiGridItemWrapper(
            params: params,
            action: { emoji, _ in pickEmoji(emoji) },
            popoverSelection: $popoverSelection, 
            content: { item(params) }
        )
        .font(style.font)
        .onTapGesture {
            if popoverSelection != nil { return }
            selectEmoji(emoji, in: category, pick: true)
        }
        .onLongPressGesture {
            selectEmoji(emoji, in: category, skintonePopover: true)
        }
        .id(emoji.id(in: category))
    }

    @ViewBuilder
    func gridTitle(
        for category: EmojiCategory
    ) -> some View {
        if axis == .vertical, categories.count > 1 {
            section(
                .init(
                    category: category,
                    view: Emoji.GridSectionTitle(category)
                )
            )
            .id(category.id)
        }
    }
}

private extension EmojiGrid {
    
    func emojis(
        for category: EmojiCategory
    ) -> [Emoji] {
        switch category {
        case .frequent: frequentEmojiProvider?.emojis ?? []
        default: category.emojis
        }
    }
    
    func hasEmojis(
        for category: EmojiCategory
    ) -> Bool {
        !emojis(for: category).isEmpty
    }
    
    func isSelected(
        _ emoji: Emoji,
        in category: EmojiCategory
    ) -> Bool {
        if categories.count == 1 { return selection.matches(emoji: emoji) }
        return selection.matches(emoji: emoji, category: category)
    }
}

#Preview {
    
    struct Preview: View {

        @State
        var query = ""

        @State
        var selection = Emoji.GridSelection(emoji: .init("👼"), category: .smileysAndPeople)

        func grid(
            _ axis: Axis.Set
        ) -> some View {
            ScrollViewReader { proxy in
                ScrollView(axis) {
                    EmojiGrid(
                        axis: axis,
                        query: query,
                        selection: $selection,
                        section: { $0.view },
                        item: { $0.view }
                    )
                    .padding(5)
                }
                .onAppear {
                    proxy.scrollTo(selection)
                }
                .onChange(of: selection) { selection in
                    proxy.scrollTo(selection)
                }
            }
        }
        
        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    TextField("Search", text: $query)
                        .padding()
                    Divider()
                    grid(.vertical)
                        .frame(height: 300)
                    Divider()
                    grid(.horizontal)
                        .frame(height: 300)
                }
            }
        }
    }
    
    return Preview()
        // .emojiGridStyle(.extraLarge)
}
