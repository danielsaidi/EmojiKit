import Foundation
import SwiftUI

public extension Emoji {

    @available(*, deprecated, renamed: "GridSectionTitleParameters")
    typealias GridSectionParameters = GridSectionTitleParameters
}

@available(*, deprecated, renamed: "EmojiGridScrollView")
public typealias EmojiScrollGrid = EmojiGridScrollView

public extension EmojiGrid {
    
    @available(*, deprecated, message: "The emoji grid no longer takes a persisted category.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        persistedCategory: EmojiCategory.PersistedCategory,
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionTitle,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis,
            categories: categories,
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            section: section,
            item: item
        )
    }
    
    @available(*, deprecated, message: "section is renamed to sectionTitle and item to gridItem.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionTitle,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis,
            categories: categories,
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: section,
            gridItem: item
        )
    }
    
    @available(*, deprecated, message: "Use either the emojis or the categories initializer, not this one which has both.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji]?,
        categories: [EmojiCategory]?,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        geometryProxy: GeometryProxy? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping (Emoji.GridSectionTitleParameters) -> SectionTitle,
        @ViewBuilder gridItem: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        if let emojis {
            self.init(
                axis: axis,
                emojis: emojis,
                selection: selection,
                geometryProxy: geometryProxy,
                action: action,
                categoryEmojis: categoryEmojis,
                sectionTitle: sectionTitle,
                gridItem: gridItem
            )
        } else {
            self.init(
                axis: axis,
                categories: categories,
                selection: selection,
                geometryProxy: geometryProxy,
                action: action,
                categoryEmojis: categoryEmojis,
                sectionTitle: sectionTitle,
                gridItem: gridItem
            )
        }
    }
}

public extension EmojiGridScrollView {
    
    @available(*, deprecated, message: "The emoji grid no longer takes a persisted category.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        persistedCategory: EmojiCategory.PersistedCategory,
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionTitle,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis,
            categories: categories,
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            section: section,
            item: item
        )
    }
    
    @available(*, deprecated, message: "section is renamed to sectionTitle and item to gridItem.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji] = [],
        categories: [EmojiCategory] = .standard,
        query: String = "",
        selection: Binding<Emoji.GridSelection> = .constant(.init()),
        geometryProxy: GeometryProxy? = nil,
        action: @escaping (Emoji) -> Void = { _ in },
        categoryEmojis: @escaping (EmojiCategory) -> [Emoji] = { $0.emojis },
        @ViewBuilder section: @escaping (Emoji.GridSectionParameters) -> SectionTitle,
        @ViewBuilder item: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis,
            categories: categories,
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: section,
            gridItem: item
        )
    }
    
    @available(*, deprecated, message: "Use either the emojis or the categories initializer, not this one which has both.")
    init(
        axis: Axis.Set = .vertical,
        emojis: [Emoji]?,
        categories: [EmojiCategory]?,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        geometryProxy: GeometryProxy? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping (Emoji.GridSectionTitleParameters) -> SectionTitle,
        @ViewBuilder gridItem: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            emojis: emojis ?? [],
            query: query,
            selection: selection,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }
}

public extension Emoji.GridSelection {

    @available(*, deprecated, message: "Use the non-empty category variant.")
    func matches(
        emoji: Emoji?,
        category: EmojiCategory? = nil
    ) -> Bool {
        self.emoji == emoji && self.category == category
    }

    @available(*, deprecated, message: "Use the non-empty category variant.")
    func isSelected(
        emoji: Emoji?,
        in category: EmojiCategory? = nil
    ) -> Bool {
        self.emoji == emoji && self.category == category
    }
}
