//
//  Emoji+GridDirection.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-01-08.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {
    
    /// This enum defines the available directions in a grid.
    ///
    /// It is all internal for now, since this interface may change in the future.
    enum GridDirection {
        
        case up, down, left, right
        
        func destinationIndex(
            for axis: Axis.Set,
            currentIndex: Int,
            itemsPerRow: Int
        ) -> Int {
            currentIndex + destinationIndexOffset(
                for: axis,
                itemsPerRow: itemsPerRow
            )
        }
        
        func destinationIndexOffset(
            for axis: Axis.Set,
            itemsPerRow: Int
        ) -> Int {
            if axis == .vertical {
                switch self {
                case .up: -itemsPerRow
                case .down: itemsPerRow
                case .left: -1
                case .right: 1
                }
            } else {
                switch self {
                case .up: -1
                case .down: 1
                case .left: -itemsPerRow
                case .right: itemsPerRow
                }
            }
        }

        func navigationDirection(
            for axis: Axis.Set
        ) -> GridNavigationDirection {
            switch self {
            case .up, .left: .back
            case .down, .right: .forward
            }
        }
        
        func transform(
            for layoutDirection: LayoutDirection
        ) -> GridDirection {
            if layoutDirection == .rightToLeft {
                switch self {
                case .left: return .right
                case .right: return .left
                default: return self
                }
            }
            return self
        }
    }
    
    /// This enum defines the supported grid navigation directions.
    enum GridNavigationDirection: Equatable {
        case forward, back
    }
}

#if os(macOS) || os(tvOS)
extension MoveCommandDirection {

    /// The corresponding emoji grid direction.
    var emojiGridDirection: Emoji.GridDirection {
        switch self {
        case .up: .up
        case .down: .down
        case .left: .left
        case .right: .right
        @unknown default: .down
        }
    }
}
#endif
