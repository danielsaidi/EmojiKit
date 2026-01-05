//
//  Emoji+GridItem.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-01-08.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {
    
    /// This style can be used to style the ``Emoji/GridItem``.
    ///
    /// This style can be applied with ``emojiGridItemStyle(_:)``. You
    /// can use the ``standard`` style or your own style.
    struct GridItemStyle {
        
        /// Create a custom emoji grid item style.
        public init(
            cornerRadius: Double = 7
        ) {
            self.cornerRadius = cornerRadius
        }
        
        public var cornerRadius: Double
    }
}

public extension Emoji.GridItemStyle {
    
    /// This standard emoji grid item style.
    static var standard: Self {
        .init()
    }
}

public extension View {

    /// Apply a ``Emoji/GridItemStyle``.
    func emojiGridItemStyle(
        _ style: Emoji.GridItemStyle
    ) -> some View {
        self.environment(\.emojiGridItemStyle, style)
    }
}

private extension Emoji.GridItemStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: Emoji.GridItemStyle {
            .standard
        }
    }
}

public extension EnvironmentValues {

    var emojiGridItemStyle: Emoji.GridItemStyle {
        get { self [Emoji.GridItemStyle.Key.self] }
        set { self [Emoji.GridItemStyle.Key.self] = newValue }
    }
}
