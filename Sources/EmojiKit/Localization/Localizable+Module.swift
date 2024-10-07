//
//  Localizable+Module.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-10-03.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Localizable {

    /// The localized name for a certain locale.
    ///
    /// - Parameters:
    ///   - locale: The locale to use, by default `.current`.
    func localizedName(
        for locale: Locale = .current
    ) -> String {
        localizedName(for: locale, in: .module)
    }
}
