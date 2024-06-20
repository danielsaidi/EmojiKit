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
    ///   - section: A grid section title view builder.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory] = .all,
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        frequentEmojiProvider: (any FrequentEmojiProvider)? = MostRecentEmojiProvider(),
        @ViewBuilder section: @escaping SectionViewBuilder,
        @ViewBuilder item: @escaping ItemViewBuilder
    ) {
        self.categories = categories
        self.axis = axis
        self.frequentEmojiProvider = frequentEmojiProvider
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
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji],
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        frequentEmojiProvider: (any FrequentEmojiProvider)? = MostRecentEmojiProvider(),
        @ViewBuilder item: @escaping ItemViewBuilder
    ) where SectionView == Emoji.GridSectionTitle {
        let chars = emojis.map { $0.char }.joined()
        self.categories = [.custom(id: "", name: "", emojis: chars, iconName: "")]
        self.axis = axis
        self.frequentEmojiProvider = frequentEmojiProvider
        self.section = { $0.view }
        self.item = item
        self._selection = selection
    }
    
    public typealias ItemViewBuilder = (Emoji.GridItemParameters) -> ItemView
    public typealias SectionViewBuilder = (Emoji.GridSectionParameters) -> SectionView
    
    private let categories: [EmojiCategory]
    private let axis: Axis.Set
    private let frequentEmojiProvider: (any FrequentEmojiProvider)?
    private let section: SectionViewBuilder
    private let item: ItemViewBuilder
    
    @Binding
    private var selection: Emoji.GridSelection
    
    @Environment(\.emojiGridStyle)
    private var style
    
    public var body: some View {
        grid
            .onChange(of: selection) {
                guard let emoji = $0.emoji else { return }
                frequentEmojiProvider?.registerEmoji(emoji)
            }
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
            let isSelected = isSelected($0.element, in: category)
            item(
                .init(
                    emoji: $0.element,
                    category: category,
                    categoryIndex: $0.offset,
                    isSelected: isSelected,
                    view: Emoji.GridItem(
                        $0.element,
                        isSelected: isSelected
                    )
                )
            )
            .font(style.font)
            .id($0.element.id(in: category))
        }
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
                .onChange(of: selection) {
                    proxy.scrollTo($0)
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
