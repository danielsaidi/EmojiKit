//
//  EmojiGridScrollView+Deprecated.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2025-09-21.
//

import SwiftUI

public extension EmojiGrid {

    @available(*, deprecated, message: "registerSelectionFor has been renamed to addSelectedEmojiTo")
    init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory]? = nil,
        emojis: [Emoji]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection?>? = nil,
        visibleCategoryId: Binding<EmojiCategory.ID?>? = nil,
        registerSelectionFor: [EmojiCategory.Persisted],
        geometryProxy: GeometryProxy? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping SectionTitleBuilder,
        @ViewBuilder gridItem: @escaping GridItemBuilder
    ) {
        self.init(
            axis: axis,
            categories: categories,
            emojis: emojis,
            query: query,
            selection: selection,
            visibleCategoryId: visibleCategoryId,
            addSelectedEmojiTo: registerSelectionFor,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }

    @available(*, deprecated, message: "selection now uses an optional value.")
    init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory]? = nil,
        emojis: [Emoji]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>,
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
            emojis: emojis,
            query: query,
            selection: Binding(
                get: { selection.wrappedValue },
                set: { selection.wrappedValue = $0 ?? .init() }
            ),
            visibleCategoryId: nil,
            addSelectedEmojiTo:         registerSelectionFor,
            geometryProxy: geometryProxy,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }
}

public extension EmojiGridScrollView {

    @available(*, deprecated, message: "registerSelectionFor has been renamed to addSelectedEmojiTo")
    init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory]? = nil,
        emojis: [Emoji]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection?>? = nil,
        visibleCategoryId: Binding<EmojiCategory.ID?>? = nil,
        registerSelectionFor: [EmojiCategory.Persisted],
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping SectionTitleBuilder,
        @ViewBuilder gridItem: @escaping GridItemBuilder
    ) {
        self.init(
            axis: axis,
            categories: categories,
            emojis: emojis,
            query: query,
            selection: selection,
            visibleCategoryId: visibleCategoryId,
            addSelectedEmojiTo: registerSelectionFor,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }

    @available(*, deprecated, message: "selection now uses an optional value.")
    init(
        axis: Axis.Set = .vertical,
        categories: [EmojiCategory]? = nil,
        emojis: [Emoji]? = nil,
        query: String? = nil,
        selection: Binding<Emoji.GridSelection>,
        registerSelectionFor: [EmojiCategory.Persisted]? = nil,
        action: ((Emoji) -> Void)? = nil,
        categoryEmojis: ((EmojiCategory) -> [Emoji])? = nil,
        @ViewBuilder sectionTitle: @escaping SectionTitleBuilder,
        @ViewBuilder gridItem: @escaping GridItemBuilder
    ) {
        self.init(
            axis: axis,
            categories: categories,
            emojis: emojis,
            query: query,
            selection: Binding(
                get: { selection.wrappedValue },
                set: { selection.wrappedValue = $0 ?? .init() }
            ),
            visibleCategoryId: nil,
            addSelectedEmojiTo: registerSelectionFor,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }

    @available(*, deprecated, message: "Do not pass in a geometry proxy manually.")
    init(
        axis: Axis.Set = .vertical,
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
