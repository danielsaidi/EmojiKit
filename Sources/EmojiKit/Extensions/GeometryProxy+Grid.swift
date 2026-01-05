//
//  GeometryProxy+Grid.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-01-08.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension GeometryProxy {
    
    /// Calculate the number of items per emoji grid row.
    func itemsPerRow(
        for axis: Axis.Set,
        style: EmojiGridStyle
    ) -> Int {
        let vertical = axis == .vertical
        let geoSize = vertical ? size.width : size.height
        let gridSize = geoSize - 2 * style.padding
        let itemSize = style.itemSize
        let itemSpacing = style.itemSpacing
        let estItems = floor(gridSize / itemSize)
        #if os(iOS)
        let reduction = 3.0
        #else
        let reduction = 2.0
        #endif
        let estSlots = estItems - reduction
        let estTotalItemSize = gridSize - itemSpacing * estSlots
        let estTotalItems = floor(estTotalItemSize/itemSize)
        return Int(estTotalItems)
    }
}
