//
//  EmojiGridScrollView+Deprecated.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2025-09-21.
//

import SwiftUI

public extension EmojiGridScrollView {

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
            selection: selection,
            action: action,
            categoryEmojis: categoryEmojis,
            sectionTitle: sectionTitle,
            gridItem: gridItem
        )
    }
}
