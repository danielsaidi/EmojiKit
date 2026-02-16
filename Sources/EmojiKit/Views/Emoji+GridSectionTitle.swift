//
//  Emoji+GridSectionTitle.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-12-27.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {
    
    /// This view can be used as a category section title in e.g. ``EmojiGrid``.
    ///
    /// This view is currently not customizable, since views in this library will let
    /// you customize their section view instead of customizing this view.
    struct GridSectionTitle: View {
        
        public init(
            _ category: EmojiCategory,
            locale: Locale = .current
        ) {
            self.category = category
            self.locale = locale
        }
        
        private let category: EmojiCategory
        private let locale: Locale

        public var body: some View {
            Text(category.labelText(for: locale).uppercased())
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(4)
        }
    }
}

#Preview {
    VStack {
        Emoji.GridSectionTitle(.activity)
        Emoji.GridSectionTitle(.custom(id: "foo", name: "My Category", emojis: [], iconName: "face.smiling"))
    }
}
