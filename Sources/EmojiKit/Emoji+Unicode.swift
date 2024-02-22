//
//  Emoji+Unicode.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Emoji {
    
    /// The emoji's unique unicode identifier.
    var unicodeIdentifier: String? {
        char.applyingTransform(.toUnicodeName, reverse: false)
    }
}
