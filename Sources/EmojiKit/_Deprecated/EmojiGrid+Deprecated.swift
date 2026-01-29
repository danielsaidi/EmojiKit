import SwiftUI

public extension EmojiGrid {

    @available(*, deprecated, message: "Do not use! Use the category/selection initializer.")
    init(
        axis: Axis.Set? = nil,
        categories: [EmojiCategory]? = nil,
        emojis: [Emoji]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        registerSelectionFor: [EmojiCategory.Persisted]? = nil,
        geometryProxy: GeometryProxy? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping SectionTitleBuilder,
        @ViewBuilder gridItem: @escaping GridItemBuilder
    ) {
        self.init(
            axis: axis,
            categories: categories,
            category: .constant(nil),
            selection: Binding(
                get: { selection?.wrappedValue },
                set: { selection?.wrappedValue = $0 ?? .init() }
            ),
            query: query,
            addSelectedEmojisTo: registerSelectionFor,
            geometryProxy: geometryProxy,
            action: action,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }
}

public extension EmojiGridScrollView {

    @available(*, deprecated, message: "Do not use! Use the category/selection initializer.")
    init(
        axis: Axis.Set? = nil,
        categories: [EmojiCategory]? = nil,
        emojis: [Emoji]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        registerSelectionFor: [EmojiCategory.Persisted]? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping SectionTitleBuilder,
        @ViewBuilder gridItem: @escaping GridItemBuilder
    ) {
        self.init(
            axis: axis,
            categories: categories,
            category: .constant(nil),
            selection: Binding(
                get: { selection?.wrappedValue },
                set: { selection?.wrappedValue = $0 ?? .init() }
            ),
            query: query,
            addSelectedEmojisTo: registerSelectionFor,
            action: action,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }

    @available(*, deprecated, message: "Do not pass in a geometry proxy manually.")
    init(
        axis: Axis.Set? = nil,
        categories: [EmojiCategory]? = nil,
        emojis: [Emoji]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>? = nil,
        geometryProxy: GeometryProxy,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping (Emoji.GridSectionTitleParameters) -> SectionTitle,
        @ViewBuilder gridItem: @escaping (Emoji.GridItemParameters) -> GridItem
    ) {
        self.init(
            axis: axis,
            categories: categories,
            emojis: emojis,
            query: query,
            selection: nil,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }
}
