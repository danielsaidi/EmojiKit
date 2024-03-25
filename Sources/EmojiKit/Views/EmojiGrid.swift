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
/// The grid can be created with either a list of categories
/// or a list of emojis. If multiple categories are provided,
/// the view will add a section title for each category.
///
/// The `section` and `content` view builders can be used to
/// customize the section titles and the grid item views. To
/// use the standard views, just return `{ $0.view }`.
///
/// You can provide a `selection` to automatically highlight
/// the currently selected item. You don't need to provide a
/// selection, for instance when the grid is only used as an
/// emoji picker.
///
/// You can style this component with ``emojiGridStyle(_:)``:
///
/// ```swift
/// EmojiGrid(...) {
///     $0.view
/// }
/// .emojiGridStyle(.large)
/// ```
///
/// You can wrap this view in a `ScrollViewReader` to scroll
/// to any emoji or category `id`.
public struct EmojiGrid<ItemView: View, SectionView: View>: View {
    
    /// Create an emoji grid with multiple categories.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - categories: The categories to list, by default `.all`.
    ///   - selection: The current grid selection, if any.
    ///   - section: A grid section title view builder.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory] = .all,
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        @ViewBuilder section: @escaping SectionViewBuilder,
        @ViewBuilder item: @escaping ItemViewBuilder
    ) {
        self.categories = categories
        self.axis = axis
        self.section = section
        self.item = item
        self._selection = selection
    }
    
    /// Create an emoji grid.
    ///
    /// - Parameters:
    ///   - axis: The grid axis, by default `.vertical`.
    ///   - emojis: The emojis to list.
    ///   - selection: The current grid selection, if any.
    ///   - section: A grid section title view builder.
    ///   - item: A grid item view builder.
    public init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji],
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        @ViewBuilder section: @escaping SectionViewBuilder,
        @ViewBuilder item: @escaping ItemViewBuilder
    ) {
        let chars = emojis.map { $0.char }.joined()
        self.categories = [.custom(id: "", name: "", emojis: chars, iconName: "")]
        self.axis = axis
        self.section = section
        self.item = item
        self._selection = selection
    }
    
    public typealias ItemViewBuilder = (Emoji.ItemParameters) -> ItemView
    public typealias SectionViewBuilder = (Emoji.SectionParameters) -> SectionView
    
    private let categories: [EmojiCategory]
    private let axis: Axis.Set
    private let section: SectionViewBuilder
    private let item: ItemViewBuilder
    
    @Binding
    private var selection: Emoji.GridSelection
    
    @Environment(\.emojiGridStyle)
    private var style
    
    public var body: some View {
        grid
    }
}

public extension Emoji {
    
    /// This struct defines item view builder parameters.
    struct ItemParameters {
        
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
    struct SectionParameters {
        
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
            if category.hasEmojis {
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
        let emojis = category.emojis
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
    
    func isSelected(
        _ emoji: Emoji,
        in category: EmojiCategory
    ) -> Bool {
        if categories.count == 1 { return selection.matches(emoji: emoji) }
        return selection.matches(emoji: emoji, category: category)
    }
}

struct EmojiPreviewButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

#Preview {
    
    struct Preview: View {
        
        @State
        var selection = Emoji.GridSelection()
        
        func grid(
            _ axis: Axis.Set
        ) -> some View {
            ScrollViewReader { proxy in
                ScrollView(axis) {
                    EmojiGrid(
                        axis: axis,
                        selection: $selection,
                        section: { $0.view },
                        item: { params in
                            Button {
                                select(params.emoji, cat: params.category, with: proxy)
                            } label: {
                                params.view
                            }
                            .buttonStyle(EmojiPreviewButtonStyle())
                        }
                    )
                    .padding(5)
                }
            }
        }
        
        func select(
            _ emoji: Emoji,
            cat: EmojiCategory,
            with proxy: ScrollViewProxy
        ) {
            selection = .init(emoji: emoji, category: cat)
            proxy.scrollTo(emoji)
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
        .emojiGridStyle(.extraLarge)
}
