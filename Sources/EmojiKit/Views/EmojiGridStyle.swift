//
//  Emoji+Grid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-02.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to modify the visual style of the
/// ``EmojiGrid`` and ``EmojiScrollGrid`` views.
///
/// You can apply the style by using the view style modifier
/// ``SwiftUICore/View/emojiGridStyle(_:)``.
///
/// You can use the ``standard`` style, any other predefined
/// styles, like ``large`` or ``extraLarge``. You can modify
/// these style, and create completely custom styles as well.
///
/// When ``prefersFocusEffect`` is `true`, the grid will get
/// a blue square around itself, to indicate if it has focus.
/// This is not really needed, since the selected emoji will
/// already be marked with a blue square, but it's up to you.
public struct EmojiGridStyle {

    /// Create a style with an identical font and item size.
    ///
    /// - Parameters:
    ///   - fontSize: The font size to use, by default `30`.
    ///   - itemSpacing: The grid item spacing, by default `5`.
    ///   - padding: The padding to apply to the grid, by default `5`.
    ///   - prefersFocusEffect: Whether the grid should disable its focus effect, by default `false`.
    public init(
        fontSize: CGFloat = 30,
        itemSpacing: CGFloat = 5,
        padding: Double = 5,
        prefersFocusEffect: Bool = false
    ) {
        self.init(
            font: .system(size: fontSize),
            itemSize: fontSize,
            itemSpacing: itemSpacing,
            padding: padding,
            prefersFocusEffect: prefersFocusEffect
        )
    }

    /// Create a style with an individual font and item size.
    ///
    /// - Parameters:
    ///   - font: The font to use, by default `.title`.
    ///   - itemSize: The item size to use, by default `30`.
    ///   - itemSpacing: The grid item spacing, by default `5`.
    ///   - padding: The padding to apply to the grid, by default `5`.
    ///   - prefersFocusEffect: Whether the grid should disable its focus effect, by default `false`.
    public init(
        font: Font? = .title,
        itemSize: CGFloat = 30,
        itemSpacing: CGFloat = 5,
        padding: Double = 5,
        prefersFocusEffect: Bool = false
    ) {
        self.font = font
        self.itemSize = itemSize
        self.itemSpacing = itemSpacing
        self.items = [GridItem(
            .adaptive(minimum: itemSize),
            spacing: itemSpacing
        )]
        self.padding = padding
        self.prefersFocusEffect = prefersFocusEffect
    }
    
    /// The font to use.
    public var font: Font?
    
    /// The grid item size to use.
    public var itemSize: CGFloat
    
    /// The grid item spacing.
    public var itemSpacing: CGFloat
    
    /// The grid items.
    public var items: [GridItem]

    /// The padding to apply to the grid.
    public var padding: Double

    /// Whether the grid should disable its focus effect.
    public var prefersFocusEffect: Bool
}

public extension EmojiGridStyle {
    
    /// This standard emoji grid style.
    static var standard: Self {
        #if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
        .init()
        #elseif os(tvOS)
        .init(font: .largeTitle, itemSize: 80, itemSpacing: 10)
        #endif
    }
    
    /// A small size emoji grid style.
    static var small: Self {
        .init(fontSize: sizeBase)
    }
    
    /// A medium size emoji grid style.
    static var medium: Self {
        .init(fontSize: sizeBase + (1 * sizeStep))
    }
    
    /// A large size emoji grid style.
    static var large: Self {
        .init(fontSize: sizeBase + (2 * sizeStep))
    }
    
    /// An extra large size emoji grid style.
    static var extraLarge: Self {
        .init(fontSize: sizeBase + (3 * sizeStep))
    }
    
    /// An extra, extra large size emoji grid style.
    static var extraExtraLarge: Self {
        .init(fontSize: sizeBase + (4 * sizeStep))
    }
}

extension EmojiGridStyle {
    
    static var sizeBase: Double {
        #if os(tvOS)
        80
        #elseif os(iOS) || os(visionOS)
        40
        #else
        30
        #endif
    }
    
    static var sizeStep: Double {
        #if os(macOS)
        5
        #else
        10
        #endif
    }
    
    static var spacingBase: Double {
        #if os(tvOS)
        10
        #else
        5
        #endif
    }
}


public extension View {

    /// Apply a ``EmojiGridStyle``.
    func emojiGridStyle(
        _ style: EmojiGridStyle
    ) -> some View {
        self.environment(\.emojiGridStyle, style)
    }
}

private extension EmojiGridStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: EmojiGridStyle {
            .standard
        }
    }
}

public extension EnvironmentValues {

    var emojiGridStyle: EmojiGridStyle {
        get { self [EmojiGridStyle.Key.self] }
        set { self [EmojiGridStyle.Key.self] = newValue }
    }
}
