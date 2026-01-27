//
//  EmojiGrid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-02.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This grid can be used to list emojis and categories in a
/// non-scrolling vertical or horizontal grid.
///
/// This grid can change `selection` with the arrow keys and
/// trigger an `action` when emojis are selected with return
/// or by tapping an emoji. Note that some bindings only has
/// a visible effect on iOS 18+ and aligned versions.
///
/// See <doc:Views-Article> for more information about grids.
public struct EmojiGrid<SectionTitle: View, GridItem: View>: View {
    
    /// Create an emoji grid.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - categories: The categories to list, by default `.standardGrid`.
    ///   - category: The currently visible category, if any.
    ///   - selection: An grid selection binging, if any.
    ///   - query: The search query to apply, if any.
    ///   - addSelectedEmojisTo: The categories to update on selection, by default `frequent` and `recent`.
    ///   - geometryProxy: An optional geometry proxy for arrow/move-based navigation.
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
        geometryProxy: GeometryProxy? = nil,
        action: ((Emoji) -> Void)? = nil,
        @ViewBuilder sectionTitle: @escaping SectionTitleBuilder,
        @ViewBuilder gridItem: @escaping GridItemBuilder
    ) {
        let categories = categories ?? .standardGrid
        self.axis = axis ?? .vertical
        self.categories = categories.gridCategories(forQuery: query)
        self._category = category
        self._selection = selection
        self.query = query ?? ""
        self.addSelectedEmojisTo = addSelectedEmojisTo ?? [.frequent, .recent]
        self.geometryProxy = geometryProxy
        self.action = action ?? { _ in }
        self.sectionTitle = sectionTitle
        self.gridItem = gridItem
    }

    @Binding var category: EmojiCategory?
    @Binding var selection: Emoji.GridSelection?

    private let axis: Axis.Set
    private let categories: [EmojiCategory]
    private let query: String
    private let addSelectedEmojisTo: [EmojiCategory.Persisted]
    private let geometryProxy: GeometryProxy?
    private let action: (Emoji) -> Void

    private let sectionTitle: (Emoji.GridSectionTitleParameters) -> SectionTitle
    private let gridItem: (Emoji.GridItemParameters) -> GridItem

    public typealias SectionTitleBuilder = (Emoji.GridSectionTitleParameters) -> SectionTitle
    public typealias GridItemBuilder = (Emoji.GridItemParameters) -> GridItem

    @Environment(\.emojiGridStyle) var style
    @Environment(\.layoutDirection) var layoutDirection

    @State var popoverSelection: Emoji.GridSelection?

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
                    case .downArrow: result = handleArrowKey(.down)
                    case .leftArrow: result = handleArrowKey(.left)
                    case .return: result = handleReturn($0)
                    case .rightArrow: result = handleArrowKey(.right)
                    case .upArrow: result = handleArrowKey(.up)
                    default: result = false
                    }
                    return result ? .handled : .ignored
                }
                #endif
                #if os(tvOS)
                .onMoveCommand(perform: selectEmoji)
                #endif
        } else {
            grid
        }
    }
}

private extension EmojiGrid {
    
    var grid: some View {
        gridView
            .padding(style.padding)
    }

    @ViewBuilder
    var gridView: some View {
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
        ForEach(Array(categories.enumerated()), id: \.offset) {
            let offset = $0.offset
            let category = $0.element
            if category.hasEmojis {
                Section {
                    gridContent(
                        for: category,
                        at: offset
                    )
                } header: {
                    if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
                        sectionTitle(for: category, at: offset)
                            .onScrollVisibilityChange { isVisible in
                                guard isVisible else { return }
                                self.category = category
                            }
                    } else {
                        sectionTitle(for: category, at: offset)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func gridContent(
        for category: EmojiCategory,
        at index: Int
    ) -> some View {
        ForEach(Array(category.emojis.enumerated()), id: \.offset) {
            gridContent(
                for: category,
                at: index,
                emoji: $0.element,
                emojiIndex: $0.offset
            )
        }
    }

    @ViewBuilder
    func gridContent(
        for category: EmojiCategory,
        at categoryIndex: Int,
        emoji: Emoji,
        emojiIndex: Int
    ) -> some View {
        let params = Emoji.GridItemParameters(
            emoji: emoji,
            emojiIndex: emojiIndex,
            category: category,
            categoryIndex: categoryIndex,
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
            content: { gridItem(params) }
        )
        .font(style.font)
        .onTapGesture {
            if popoverSelection != nil { return }
            selectEmoji(emoji, in: category, pick: true)
        }
        // .prefersDraggable(emoji)     TODO: Fix Conflicts with popover
        .onLongPressGesture {
            selectEmoji(emoji, in: category, skintonePopover: true)
        }
        .id(emoji.id(in: category))
    }

    @ViewBuilder
    func sectionTitle(
        for category: EmojiCategory,
        at index: Int
    ) -> some View {
        if axis == .vertical, categories.count > 1 {
            sectionTitle(
                .init(
                    category: category,
                    index: index,
                    view: Emoji.GridSectionTitle(category)
                )
            )
            .id(category.id)
            .padding(.top, index > 0 ? style.sectionSpacing : 0)
        }
    }
}

private extension EmojiGrid {

    func handleArrowKey(_ direction: Emoji.GridDirection) -> Bool {
        selectEmoji(with: direction)
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
        action(emoji)
        addSelectedEmojisTo.forEach {
            $0.addEmoji(emoji)
        }
    }

    func pickSelectedEmoji() -> Bool {
        guard let emoji = selection?.emoji else { return false }
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
        let direction = direction.transform(for: layoutDirection)
        let navDirection = direction.navigationDirection(for: axis)
        guard let selection else { return selectFirstCategory() }
        guard let category = selection.category else { return }
        let emojis = category.emojis
        guard let emoji = selection.emoji else { return }
        guard let index = emojis.firstIndex(of: emoji) else { return }

        let itemsPerRow = geo.itemsPerRow(
            for: axis,
            style: style
        )

        let newIndex = direction.destinationIndex(
            for: axis,
            currentIndex: index,
            itemsPerRow: itemsPerRow
        )

        if let emoji = emojis.emoji(at: newIndex) {
            selectEmoji(emoji, in: category)
        } else if navDirection == .back {
            guard
                let cat = categories.category(before: category),
                let emoji = emojis.last
            else { return }
            selectEmoji(emoji, in: cat)
        } else {
            guard
                let cat = categories.category(after: category),
                let emoji = emojis.first
            else { return }
            selectEmoji(emoji, in: cat)
        }
    }

    func selectFirstCategory() {
        let firstNonEmpty = categories.first { $0.emojis.isEmpty }
        guard let category = firstNonEmpty else { return }
        let emoji = category.emojis.first
        selection = .init(emoji: emoji, category: category)
    }

    func showPopoverForSelection() -> Bool {
        popoverSelection = selection
        return true
    }
}

private extension View {
    
    @ViewBuilder
    func prefersDraggable(
        _ emoji: Emoji
    ) -> some View {
        #if os(watchOS) || os(tvOS)
        self
        #else
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            self.draggable(emoji)
        } else {
            self
        }
        #endif
    }
}

private extension EmojiGrid {
    
    func isSelected(
        _ emoji: Emoji,
        in category: EmojiCategory
    ) -> Bool {
        selection?.isSelected(emoji: emoji, in: category) == true
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
                            category: $category,
                            selection: $selection,
                            query: query,
                            action: { print($0.char) },
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

                    Divider()

                    Button("Change") {
                        selection = .init(emoji: .init("🤯"), category: .smileysAndPeople)
                    }
                }
                .navigationTitle(category?.localizedName ?? "Preview")
            }
        }
    }
    
    return Preview()
}
