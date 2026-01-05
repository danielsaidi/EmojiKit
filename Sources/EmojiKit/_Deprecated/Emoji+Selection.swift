//
//  Emoji+Selection.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2025-01-08.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Emoji {
    
    @available(*, deprecated, message: "Use the persisted emojis directly instead.")
    func registerUserSelection() {
        EmojiCategory.Persisted.frequent.addEmoji(self)
    }
}
