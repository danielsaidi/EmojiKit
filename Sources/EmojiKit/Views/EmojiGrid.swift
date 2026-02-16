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
/// > Important: The selection will for instance change when
/// navigating using the arrow keys. The action is then only
/// triggered when pressing the return key on an emoji.
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
    ///   - addSelectedEmojisTo: The categories add selected emojis to, by default `frequent` and `recent`.
    ///   - geometryProxy: An optional geometry proxy for arrow/move-based navigation.
    ///   - scrollViewProxy: An optional scroll view proxy for scroll-based behaviors.
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
        scrollViewProxy: ScrollViewProxy? = nil,
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
        self.scrollViewProxy = scrollViewProxy
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
    private let scrollViewProxy: ScrollViewProxy?
    private let action: (Emoji) -> Void

    private let sectionTitle: (Emoji.GridSectionTitleParameters) -> SectionTitle
    private let gridItem: (Emoji.GridItemParameters) -> GridItem

    public typealias SectionTitleBuilder = (Emoji.GridSectionTitleParameters) -> SectionTitle
    public typealias GridItemBuilder = (Emoji.GridItemParameters) -> GridItem

    @Environment(\.emojiGridStyle) var style
    @Environment(\.layoutDirection) var layoutDirection

    @State private var isInternalChange = false
    @State private var isScrollingToSelection = false
    @State private var popoverSelection: Emoji.GridSelection?
    @State private var visibleEmojiIds: Set<String> = []

    public var body: some View {
        bodyWithPreferredModifiers
            .onAppear(perform: setup)
            .onChange(of: category, perform: setCategoryExternal)
            .onChange(of: selection, perform: setSelectionExternal)
            .padding(style.padding)
    }

    @ViewBuilder
    private var bodyWithPreferredModifiers: some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            grid.focusable(true)
                .focusEffectDisabled(!style.prefersFocusEffect)
                #if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)
                .onKeyPress { handleKeyPress($0) }
                #endif
                #if os(tvOS)
                .onMoveCommand { selectEmoji(with: $0.emojiGridDirection) }
                #endif
        } else {
            grid
        }
    }
}

// MARK: - View Logic

private extension EmojiGrid {

    #if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)
    @MainActor
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    func handleKeyPress(_ keyPress: KeyPress) -> KeyPress.Result {
        guard keyPress.phase == .down else { return .ignored }
        let result: Bool
        switch keyPress.key {
        case .downArrow: result = handleKeyPressOnArrow(.down)
        case .leftArrow: result = handleKeyPressOnArrow(.left)
        case .return: result = handleKeyPressOnReturn(keyPress)
        case .rightArrow: result = handleKeyPressOnArrow(.right)
        case .upArrow: result = handleKeyPressOnArrow(.up)
        default: result = false
        }
        return result ? .handled : .ignored
    }

    func handleKeyPressOnArrow(_ direction: Emoji.GridDirection) -> Bool {
        selectEmoji(with: direction)
        return true
    }

    @available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, *)
    func handleKeyPressOnReturn(_ press: SwiftUI.KeyPress) -> Bool {
        if press.modifiers.isEmpty { return pickSelectedEmoji() }
        if press.modifiers == .option { return showPopover(for: selection) }
        return false
    }
    #endif

    func handleLongPress(on emoji: Emoji, in category: EmojiCategory) {
        showPopover(for: .init(emoji: emoji, category: category))
    }

    func handleTap(on emoji: Emoji, in category: EmojiCategory) {
        if popoverSelection != nil { return }
        pickEmoji(emoji)
        setSelectionInternal(.init(emoji: emoji, category: category))
    }

    func handleVisibility(_ isVisible: Bool, for emoji: Emoji, in category: EmojiCategory) {
        let id = emoji.id(in: category)
        if isVisible {
            visibleEmojiIds.insert(id)
        } else {
            visibleEmojiIds.remove(id)
        }
    }

    func handleVisibility(_ isVisible: Bool, for category: EmojiCategory) {
        guard isVisible, !isScrollingToSelection else { return }
        setCategoryInternal(category)
    }

    func isSelectionVisible(_ selection: Emoji.GridSelection?) -> Bool {
        guard
            let emoji = selection?.emoji,
            let category = selection?.category
        else { return false }
        let id = emoji.id(in: category)
        return visibleEmojiIds.contains(id)
    }

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

    func selectCategory(_ category: EmojiCategory?) {
        guard let category else { return }
        setSelectionInternal(.init(category: category))
    }

    func selectEmoji(_ emoji: Emoji, in category: EmojiCategory) {
        setSelectionInternal(.init(emoji: emoji, category: category))
    }

    func selectEmoji(with direction: Emoji.GridDirection) {
        guard let geo = geometryProxy else { return }
        let direction = direction.transform(for: layoutDirection)
        let navDirection = direction.navigationDirection(for: axis)
        guard let selection else { return selectCategory(category ?? categories.first) }
        guard let category = selection.category else { return }
        let emojis = category.emojis
        guard let emoji = selection.emoji else { return }
        guard let index = emojis.firstIndex(of: emoji) else { return }

        let itemsPerRow = geo.itemsPerRow(for: axis, style: style)
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
                let emoji = cat.emojis.last
            else { return }
            selectEmoji(emoji, in: cat)
        } else {
            guard
                let cat = categories.category(after: category),
                let emoji = cat.emojis.first
            else { return }
            selectEmoji(emoji, in: cat)
        }
    }

    func setCategoryExternal(_ category: EmojiCategory?) {
        defer { isInternalChange = false }
        if isInternalChange { return }
        scrollViewProxy?.scrollToCategory(category)
    }

    func setCategoryInternal(_ category: EmojiCategory) {
        isInternalChange = true
        self.category = category
    }

    func setSelectionExternal(_ selection: Emoji.GridSelection?) {
        if isSelectionVisible(selection) { return }
        scrollViewProxy?.scrollToSelection(selection)
    }

    func setSelectionInternal(_ selection: Emoji.GridSelection) {
        self.selection = selection
    }

    func setup() {
        setupInitialCategory()
    }

    func setupInitialCategory() {
        let category = category ?? selection?.category
        guard let category else { return }
        isScrollingToSelection = true
        Task {
            scrollViewProxy?.scrollToCategory(category)
            isScrollingToSelection = false
        }
    }

    @discardableResult
    func showPopover(for selection: Emoji.GridSelection?) -> Bool {
        guard let selection else { return false }
        popoverSelection = selection
        return true
    }
}

// MARK: - Views

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
        ForEach(Array(categories.enumerated()), id: \.offset) {
            let category = $0.element
            if category.hasEmojis {
                gridSection(for: category, at: $0.offset)
            }
        }
    }

    func gridSection(for category: EmojiCategory, at index: Int) -> some View {
        Section {
            let emojis = category.emojis.enumerated()
            ForEach(Array(emojis), id: \.offset) {
                gridItem(for: (category, index), emoji: ($0.element, $0.offset))
            }
        } header: {
            gridSectionHeader(for: category, at: index)
        }
        .id(category.id)
    }

    @ViewBuilder
    func gridSectionHeader(for category: EmojiCategory, at index: Int) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            gridSectionTitle(for: category, at: index)
                .onScrollVisibilityChange {
                    handleVisibility($0, for: category)
                }
        } else {
            gridSectionTitle(for: category, at: index)
        }
    }

    @ViewBuilder
    func gridSectionTitle(for category: EmojiCategory, at index: Int) -> some View {
        if axis == .vertical, categories.count > 1 {
            let view = Emoji.GridSectionTitle(category)
            sectionTitle(.init(category: category, index: index, view: view))
                .padding(.top, index > 0 ? style.sectionSpacing : 0)
        }
    }

    @ViewBuilder
    func gridItem(for category: (EmojiCategory, Int), emoji: (Emoji, Int)) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            gridItemView(for: category, emoji: emoji)
                .onScrollVisibilityChange {
                    handleVisibility($0, for: emoji.0, in: category.0)
                }
        } else {
            gridItemView(for: category, emoji: emoji)
        }
    }

    func gridItemView(for category: (EmojiCategory, Int), emoji: (Emoji, Int)) -> some View {
        EmojiGridItemWrapper(
            emoji: emoji.0,
            category: category.0,
            action: { emoji, _ in pickEmoji(emoji) },
            popoverSelection: $popoverSelection,
            content: {
                let isSelected = isSelected(emoji.0, in: category.0)
                gridItem(Emoji.GridItemParameters(
                    emoji: emoji.0,
                    emojiIndex: emoji.1,
                    category: category.0,
                    categoryIndex: category.1,
                    isSelected: isSelected,
                    view: Emoji.GridItem(emoji.0, isSelected: isSelected)
                ))
            }
        )
        // .draggable(emoji) TODO: Fix Conflicts with popover
        .font(style.font)
        .onLongPressGesture { handleLongPress(on: emoji.0, in: category.0) }
        .onTapGesture { handleTap(on: emoji.0, in: category.0) }
        .id(emoji.0.id(in: category.0))
    }
}

// MARK: - Functions

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

        let axis = Axis.Set.vertical

        @State var category: EmojiCategory? = .smileysAndPeople
        @State var query: String = ""
        @State var selection: Emoji.GridSelection? = nil // .init(emoji: .init("🍵"), category: .foodAndDrink)

        var body: some View {
            NavigationStack {
                GeometryReader { geo in
                    ScrollViewReader { scroll in
                        ScrollView(axis) {
                            EmojiGrid(
                                axis: axis,
                                categories: .standardGrid,
                                category: $category,
                                selection: $selection,
                                query: query,
                                geometryProxy: geo,
                                scrollViewProxy: scroll,
                                action: { print($0) },
                                sectionTitle: { $0.view },
                                gridItem: { $0.view }
                            )
                            .navigationTitle(category?.localizedName ?? "EmojiPicker")
                            .toolbar {
                                Button("Select") {
                                    selection = .init(emoji: .init("🍵"), category: .foodAndDrink)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    return Preview()
}
