/*

//
//  Emojis+Version.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-01.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum defines all the Emoji versions that are currently
 supported by macOS.
 
 You can use ``all`` to get all available emoji versions, or
 use any of the platform- or OS-based ones to get the latest
 version supported by that platform/OS.
 
 ``EmojiCategory`` will automatically remove all emojis that
 are not available for the current runtime.
 */
public struct EmojiVersion: Equatable {
    
    /**
     An internal emoji version initializer.
     
     - Parameters:
       - version: The emoji version number.
       - emojis: The emojis that were released in this version.
       - iOS: The iOS version that first included this version.
       - macOS: The macOS version that first included this version.
       - tvOS: The tvOS version that first included this version.
       - watchOS: The watchOS version that first included this version
     */
    init(
        version: Double,
        emojis: [String],
        iOS: Double,
        macOS: Double,
        tvOS: Double,
        watchOS: Double
    ) {
        let allEmojis = emojis.flatMap {
            let emoji = Emoji($0)
            let skintones = (try? emoji.skinToneVariants) ?? []
            let emojis = emoji.hasSkinToneVariants ? skintones : [emoji]
            return emojis.contains(emoji) ? emojis : [emoji] + emojis
        }
        self.emojisInternal = allEmojis
        self.version = version
        self.iOS = iOS
        self.macOS = macOS
        self.tvOS = tvOS
        self.watchOS = watchOS
    }
    
    init?(lastIn list: [Self]) {
        if let version = list.last {
            self = version
        } else {
            return nil
        }
    }
    
    /// Get the latest version for an iOS version.
    public init?(
        iOS version: Double
    ) throws {
        self.init(lastIn: try Self.allAvailableIn(iOS: version))
    }
    
    /// Get the latest version for a macOS version.
    public init?(
        macOS version: Double
    ) throws {
        self.init(lastIn: try Self.allAvailableIn(macOS: version))
    }
    
    /// Get the latest version for a tvOS version.
    public init?(
        tvOS version: Double
    ) throws {
        self.init(lastIn: try Self.allAvailableIn(tvOS: version))
    }
    
    /// Get the latest version for a watchOS version.
    public init?(
        watchOS version: Double
    ) throws {
        self.init(lastIn: try Self.allAvailableIn(watchOS: version))
    }
    
    /// The emojis to include in the information.
    let emojisInternal: [Emoji]
    
    /// The emojis to include in the information.
    public var emojis: [Emoji] { emojisInternal }
    
    /// The emoji version in which emojis became available.
    public let version: Double
    
    /// The iOS version in which emojis became available.
    public let iOS: Double
    
    /// The macOS version in which emojis became available.
    public let macOS: Double
    
    /// The tvOS version in which emojis became available.
    public let tvOS: Double
    
    /// The watchOS version in which emojis became available.
    public let watchOS: Double
}


// MARK: - Public functions

public extension Emoji.Version {
    
    /// Emoji Version 15.0.
    static var v15: Self {
        get throws {
            try .init(
                emojis: "🫨🫸🫷🪿🫎🪼🫏🪽🪻🫛🫚🪇🪈🪮🪭🩷🩵🩶🪯🛜".chars,
                version: 15.0,
                iOS: 16.4,
                macOS: 13.3,
                tvOS: 16.4,
                watchOS: 9.4
            )
        }
    }

    /// Emoji Version 14.0.
    static var v14: Self {
        get throws {
            try .init(
                emojis: "🫠🫢🫣🫡🫥🫤🥹🫱🫲🫳🫴🫰🫵🫶🫦🫅🫃🫄🧌🪸🪷🪹🪺🫘🫗🫙🛝🛞🛟🪬🪩🪫🩼🩻🫧🪪🟰🫱🏻🫲🏻🫳🏻🫴🏻🫰🏻🫵🏻🫶🏻🤝🏻🫅🏻🫃🏻🫄🏻".chars,
                version: 14.0,
                iOS: 15.4,
                macOS: 12.3,
                tvOS: 15.4,
                watchOS: 8.5
            )
        }
    }
            
    /// Emoji Version 13.1.
    static var v13_1: Self {
        get throws {
            try .init(
                emojis: "😶‍🌫️😮‍💨😵‍💫❤️‍🔥❤️‍🩹🧔‍♂️🧔‍♀️💏🏻👩🏻‍❤️‍💋‍👨🏻👨🏻‍❤️‍💋‍👨🏻👩🏻‍❤️‍💋‍👩🏻💑🏻👩🏻‍❤️‍👨🏻👨🏻‍❤️‍👨🏻👩🏻‍❤️‍👩🏻".chars,
                version: 13.1,
                iOS: 14.5,
                macOS: 11.3,
                tvOS: 14.5,
                watchOS: 7.4
            )
        }
    }
    
    /// Emoji Version 13.0.
    static var v13: Self {
        get throws {
            try .init(
                emojis: "🥲🥸🤌🫀🫁🥷🫂🦬🦣🦫🦤🪶🦭🪲🪳🪰🪱🪴🫐🫒🫑🫓🫔🫕🫖🧋🪨🪵🛖🛻🛼🪄🪅🪆🪡🪢🩴🪖🪗🪘🪙🪃🪚🪛🪝🪜🛗🪞🪟🪠🪤🪣🪥🪦🪧⚧️🤌🏻🥷🏻🤵‍♂️🤵‍♀️👰‍♂️👰‍♀️👩‍🍼👨‍🍼🧑‍🍼🧑‍🎄🐈‍⬛🐻‍❄️🏳️‍⚧️".chars,
                version: 13.0,
                iOS: 14.2,
                macOS: 11.1,
                tvOS: 14.2,
                watchOS: 7.1
            )
        }
    }

    /// Emoji Version 12.1.
    static var v12_1: Self {
        get throws {
            try .init(
                emojis: "🧑‍🦰🧑‍🦱🧑‍🦳🧑‍🦲🧑‍⚕️🧑‍🎓🧑‍🏫🧑‍⚖️🧑‍🌾🧑‍🍳🧑‍🔧🧑‍🏭🧑‍💼🧑‍🔬🧑‍💻🧑‍🎤🧑‍🎨🧑‍✈️🧑‍🚀🧑‍🚒🧑‍🦯🧑‍🦼🧑‍🦽🧑🏻‍🤝‍🧑🏼👩🏻‍🤝‍👩🏼👨🏻‍🤝‍👨🏼".chars,
                version: 12.1,
                iOS: 12.1,
                macOS: 10.14,
                tvOS: 12.1,
                watchOS: 5.1
            )
        }
    }
    
    /// Emoji Version 12.0.
    static var v12: Self {
        get throws {
            try .init(
                emojis: "🥱🤎🤍🤏🦾🦿🦻🧏🧍🧎🦧🦮🦥🦦🦨🦩🧄🧅🧇🧆🧈🦪🧃🧉🧊🛕🦽🦼🛺🪂🪐🤿🪀🪁🦺🥻🩱🩲🩳🩰🪕🪔🪓🦯🩸🩹🩺🪑🪒🟠🟡🟢🟣🟤🟥🟧🟨🟩🟦🟪🟫🤏🏻🦻🏻🧏🏻🧏‍♂️🧏‍♀️🧍🏻🧍‍♂️🧍‍♀️🧎🏻🧎‍♂️🧎‍♀️👨‍🦯👩‍🦯👨‍🦼👩‍🦼👨‍🦽👩‍🦽🧑‍🤝‍🧑👭🏻👫🏻👬🏻🐕‍🦺".chars,
                version: 12.0,
                iOS: 12.1,
                macOS: 10.14,
                tvOS: 12.1,
                watchOS: 5.1
            )
        }
    }

    /// Emoji Version 11.0.
    static var v11: Self {
        get throws {
            try .init(
                emojis: "🥰🥵🥶🥴🥳🥺🦵🦶🦷🦴🦸🦹🦝🦙🦛🦘🦡🦢🦚🦜🦟🦠🥭🥬🥯🧂🥮🦞🧁🧭🧱🛹🧳🧨🧧🥎🥏🥍🧿🧩🧸♟️🧵🧶🥽🥼🥾🥿🧮🧾🧰🧲🧪🧫🧬🧴🧷🧹🧺🧻🧼🧽🧯♾️🦵🏻🦶🏻👨‍🦰👨‍🦱👨‍🦳👨‍🦲👩‍🦰👩‍🦱👩‍🦳👩‍🦲🦸🏻🦸‍♂️🦸‍♀️🦹🏻🦹‍♂️🦹‍♀️🏴‍☠️".chars,
                version: 11.0,
                iOS: 11.1,
                macOS: 10.13,
                tvOS: 11.1,
                watchOS: 4.1
            )
        }
    }
    
    /// The ``Emoji/Version`` that is used by the current OS.
    static var current: Self {
        get throws {
            if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
                return try .v15
            } else if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 8.5, *) {
                return try .v14
            }
            return try .v13_1
        }
    }
    
    /// All currently unavailable emojis.
    static var currentUnavailableEmojis: [Emoji] {
        get throws {
            if let emojis = _currentUnavailableEmojis { return emojis }
            try License.validateThisFeature()
            let version = try current
            let emojis = try version.unavailableEmojis
            _currentUnavailableEmojis = emojis
            return emojis
        }
    }
    
    /// All currently unavailable emojis, performance cached.
    static var _currentUnavailableEmojis: [Emoji]?
    
    /// All currently unavailable emojis.
    static var currentUnavailableEmojisDictionary: [String: Emoji] {
        get throws {
            if let dict = _currentUnavailableEmojisDictionary { return dict }
            try License.validateThisFeature()
            let emojis = try currentUnavailableEmojis
            let values = emojis.map { ($0.char, $0) }
            let dict = Dictionary(uniqueKeysWithValues: values)
            _currentUnavailableEmojisDictionary = dict
            return dict
        }
    }
    
    /// All currently unavailable emojis, performance cached.
    static var _currentUnavailableEmojisDictionary: [String: Emoji]?

    /// All currently available Emoji versions.
    static var all: [Self] {
        get throws {
            [try .v11, try .v12, try .v12_1, try .v13, try .v13_1, try .v14, try .v15]
        }
    }
    
    /// All available emoji versions.
    static var allAvailable: [Self] {
        get throws {
            try allAvailableIn()
        }
    }
    
    /// All system versions that available for the criteria.
    static func allAvailableIn(
        _ version: Double = 1_000,
        iOS: Double = 1_000,
        macOS: Double = 1_000,
        tvOS: Double = 1_000,
        watchOS: Double = 1_000
    ) throws -> [Self] {
        try all.filter {
            $0.version <= version &&
            $0.iOS <= iOS &&
            $0.macOS <= macOS &&
            $0.tvOS <= tvOS &&
            $0.watchOS <= watchOS
        }
    }
    
    /// Get all earlier Emoji versions for this version.
    var earlierVersions: [Self] {
        get throws {
            try Self.all.filter { $0.version < version }
        }
    }
    
    /// Get all later Emoji versions for this version.
    var laterVersions: [Self] {
        get throws {
            try Self.all.filter { $0.version > version }
        }
    }

    /// Get all older Emoji versions specified by this type.
    var olderVersions: [Self] {
        get throws {
            try Self.all.filter { $0.version < version }
        }
    }

    /// Get all emojis that are unavailable in this version.
    var unavailableEmojis: [Emoji] {
        get throws {
            try laterVersions.flatMap { $0.emojisInternal }
        }
    }
}

public extension Emoji {
    
    /// Check if an emoji is unavailable in the current OS.
    var isUnavailable: Bool {
        get throws {
            let dict = try Emoji.Version.currentUnavailableEmojisDictionary
            return dict[char] != nil
        }
    }
}
*/
