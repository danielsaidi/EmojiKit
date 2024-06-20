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
/// Use the ``EmojiScrollGrid`` if you want to wrap the grid
/// in a `ScrollView` that auto-scrolls to the `selection`.
///
/// The grid can be created with either a list of categories
/// or emojis. If multiple categories are provided, the grid
/// will add a section title to each category. For now, this
/// is only done for the vertical scroll axis.
///
/// The `section` and `content` view builders can be used to
/// customize the section titles and grid items. Just return
/// `0.view` to use the standard view, or use the parameters
/// to access contextual information for the view.
///
/// You can style this component with ``emojiGridStyle(_:)``,
/// for instance to determine the size of each grid item.
///
/// This grid will use a `frequentEmojiProvider` to populate
/// the ``EmojiCategory/frequent`` category.
///
/// > Important: When emojis are listed in category sections,
/// you must use ``Emoji/id(in:)`` to get a category-related
/// id for any emoji that you want to scroll to.
public struct EmojiGrid<ItemView: View, SectionView: View>: View {
    
    /// Create an emoji grid with multiple category sections.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - categories: The categories to list, by default `.all`.
    ///   - selection: The current grid selection, if any.
    ///   - frequentEmojiProvider: The ``FrequentEmojiProvider`` to use, by default a ``MostRecentEmojiProvider``.
    ///   - action: An action to trigger when an emoji is tapped or picked.
    ///   - section: A grid section title view builder.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory] = .all,
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        frequentEmojiProvider: (any FrequentEmojiProvider)? = MostRecentEmojiProvider(),
        action: @escaping EmojiAction = { _ in },
        @ViewBuilder section: @escaping SectionViewBuilder,
        @ViewBuilder item: @escaping ItemViewBuilder
    ) {
        self.categories = categories
        self.axis = axis
        self.frequentEmojiProvider = frequentEmojiProvider
        self.action = action
        self.section = section
        self.item = item
        self._selection = selection
    }
    
    /// Create an emoji grid with a single section.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - emojis: The emojis to list.
    ///   - selection: The current grid selection, if any.
    ///   - frequentEmojiProvider: The ``FrequentEmojiProvider`` to use, if any.
    ///   - action: An action to trigger when an emoji is tapped or picked.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji],
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        frequentEmojiProvider: (any FrequentEmojiProvider)? = MostRecentEmojiProvider(),
        action: @escaping EmojiAction = { _ in },
        @ViewBuilder item: @escaping ItemViewBuilder
    ) where SectionView == Emoji.GridSectionTitle {
        let chars = emojis.map { $0.char }.joined()
        self.categories = [.custom(id: "", name: "", emojis: chars, iconName: "")]
        self.axis = axis
        self.frequentEmojiProvider = frequentEmojiProvider
        self.action = action
        self.section = { $0.view }
        self.item = item
        self._selection = selection
    }
    
    public typealias EmojiAction = (Emoji) -> Void
    public typealias ItemViewBuilder = (Emoji.GridItemParameters) -> ItemView
    public typealias SectionViewBuilder = (Emoji.GridSectionParameters) -> SectionView
    
    private let categories: [EmojiCategory]
    private let axis: Axis.Set
    private let frequentEmojiProvider: (any FrequentEmojiProvider)?
    private let action: EmojiAction
    private let section: SectionViewBuilder
    private let item: ItemViewBuilder

    @Binding
    private var selection: Emoji.GridSelection
    
    @Environment(\.emojiGridStyle)
    private var style

    @State
    private var popoverSelection: Emoji.GridSelection?

    public var body: some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            grid
                .focusable(true)
                .focusEffectDisabled(!style.prefersFocusEffect)
                .onKeyPress {
                    var result: Bool
                    switch $0.key {
                    case .return: result = handleReturn($0)
                    default: result = false
                    }
                    return result ? .handled : .ignored
                }
        } else {
            grid
        }
    }
}

private extension EmojiGrid {

    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    func handleReturn(_ press: SwiftUI.KeyPress) -> Bool {
        if press.modifiers.isEmpty { return pickSelectedEmoji() }
        if press.modifiers == .option {
            popoverSelection = selection
            return true
        }
        return false
    }

    @discardableResult
    func pickEmoji(_ emoji: Emoji) {
        frequentEmojiProvider?.registerEmoji(emoji)
        action(emoji)
    }

    @discardableResult
    func pickAndSelectEmoji(_ emoji: Emoji, in category: EmojiCategory) -> Bool {
        selectEmoji(emoji, in: category)
        return pickSelectedEmoji()
    }

    @discardableResult
    func pickSelectedEmoji() -> Bool {
        guard let emoji = selection.emoji else { return false }
        pickEmoji(emoji)
        return true
    }

    func selectEmoji(_ emoji: Emoji, in category: EmojiCategory) {
        selection = .init(emoji: emoji, category: category)
    }
}

public extension Emoji {
    
    /// This struct defines item view builder parameters.
    struct GridItemParameters {
        
        /// The emoji to present.
        public let emoji: Emoji
        
        /// The category of the emoji.
        public let category: EmojiCategory
        
        /// The category index of the emoji.
        public let categoryIndex: Int
        
        /// Whether or not the emoji is selected.
        public let isSelected: Bool
        
        /// The standard grid item view.
        public let view: Emoji.GridItem
    }
    
    /// This struct defines section view builder parameters.
    struct GridSectionParameters {
        
        /// The category that is to be presented.
        public let category: EmojiCategory
        
        /// The standard grid item view.
        public let view: Emoji.GridSectionTitle
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
        item(
            .init(
                emoji: emoji,
                category: category,
                categoryIndex: offset,
                isSelected: isSelected(emoji, in: category),
                view: Emoji.GridItem(
                    emoji,
                    isSelected: isSelected(emoji, in: category)
                )
            )
        )
        .font(style.font)
        .onTapGesture { pickAndSelectEmoji(emoji, in: category) }
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

struct EmojiGridPreviewButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

#Preview {
    
    struct Preview: View {
        
        @State
        var selection = Emoji.GridSelection(emoji: .init("👼"), category: .smileysAndPeople)
        
        func grid(
            _ axis: Axis.Set
        ) -> some View {
            ScrollViewReader { proxy in
                ScrollView(axis) {
                    EmojiGrid(
                        axis: axis,
                        selection: $selection,
                        // frequentEmojiProvider: provider,
                        section: { $0.view },
                        item: { params in
                            Button {
                                select(params.emoji, in: params.category)
                            } label: {
                                params.view
                            }
                            .buttonStyle(EmojiGridPreviewButtonStyle())
                        }
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
        
        func select(
            _ emoji: Emoji,
            in cat: EmojiCategory
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
