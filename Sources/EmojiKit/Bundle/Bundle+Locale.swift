//
//  Bundle+Locale.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

extension Bundle {
    
    func bundle(for locale: Locale) -> Bundle? {
        guard let bundlePath = bundlePath(for: locale) else { return nil }
        return Bundle(path: bundlePath)
    }

    func bundlePath(for locale: Locale) -> String? {
        let localeId = locale.identifier
        let language = locale.language.languageCode?.identifier
        let idPath = bundlePath(named: localeId)
        let languagePath = bundlePath(named: language)
        return idPath ?? languagePath
    }

    func bundlePath(named name: String?) -> String? {
        path(forResource: name ?? "", ofType: "lproj")
    }
}
