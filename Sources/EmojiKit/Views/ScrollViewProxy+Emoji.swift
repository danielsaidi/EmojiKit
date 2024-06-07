//
//  ScrollViewProxy+Emoji.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-03-25.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension ScrollViewProxy {
    
    /// Scroll to a certain emoji.
    func scrollTo(_ emoji: Emoji) {
        scrollTo(emoji.id)
    }
    
    /// Scroll to a certain emoji category.
    func scrollTo(_ category: EmojiCategory) {
        scrollTo(category.id)
    }
}
