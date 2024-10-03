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
    /// This function uses the `.module` bundle, which isn't
    /// available if you add EmojiKit to a binary SDK. If so,
    /// just remove this file and replace this function with
    /// one that uses your SDK's specific bundle.
    ///
    /// - Parameters:
    ///   - locale: The locale to use, by default `.current`.
    func localizedName(
        for locale: Locale = .current
    ) -> String {
        localizedName(for: locale, in: .module)
    }
}
