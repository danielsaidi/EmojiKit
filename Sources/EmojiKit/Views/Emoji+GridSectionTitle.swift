//
//  Emoji+GridSectionTitle.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-12-27.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {
    
    /// This view can be used as a category section title in
    /// e.g. an ``EmojiGrid``.
    ///
    /// This view is currently not customizable, since views
    /// in this library will let you customize their section
    /// view instead of customizing this view.
    struct GridSectionTitle: View {
        
        public init(
            _ category: EmojiCategory
        ) {
            self.category = category
        }
        
        var category: EmojiCategory
        
        public var body: some View {
            Text(category.localizedName.uppercased())
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(4)
        }
    }
}

#Preview {
    Emoji.GridSectionTitle(.activity)
}
