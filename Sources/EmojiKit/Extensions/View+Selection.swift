//
//  View+Selection.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-06-21.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension View {

    @ViewBuilder
    func selectionBackground(
        isSelected: Bool,
        cornerRadius: Double = 10
    ) -> some View {
        self.background(selectionBackgroundShape(isSelected: isSelected))
            .containerShape(.rect(cornerRadius: cornerRadius))
    }

    func selectionBackgroundFillStyle(
        isSelected: Bool
    ) -> AnyShapeStyle {
        #if os(iOS) || os(macOS)
        switch isSelected {
        case true: .init(.selection)
        case false: .init(.clear)
        }
        #else
            .init(.clear)
        #endif
    }
    
    func selectionBackgroundShape(
        isSelected: Bool
    ) -> some View {
        ContainerRelativeShape()
            .fill(selectionBackgroundFillStyle(isSelected: isSelected))
            .aspectRatio(1, contentMode: .fill)
    }
}
