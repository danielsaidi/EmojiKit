//
//  Emoji+Unicode.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2026 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Emoji {
    
    /// The emoji's unique identifier.
    var unicodeIdentifier: String? {
        char.applyingTransform(.toUnicodeName, reverse: false)
    }
    
    /// The emoji's full, readable unicode name.
    ///
    /// Note that this may not always be what you should use
    /// to display the name to users. For that case, use the
    /// ``Localizable/localizedName`` instead.
    var unicodeName: String {
        unicodeNameComponents
            .joined(separator: " ")
    }
}

private extension Emoji {

    var unicodeNameComponents: [String] {
        unicodeIdentifier?
            .replacingOccurrences(of: "\\N", with: "")
            .replacingOccurrences(of: "\\n", with: "")
            .replacingOccurrences(of: "{", with: "")
            .split(separator: "}")
            .map { $0.capitalized } ?? []
    }
}
