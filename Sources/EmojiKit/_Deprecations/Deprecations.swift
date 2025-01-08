import Foundation

public extension Emoji {

    @available(*, deprecated, renamed: "matches(_:in:)")
    func matches(
        _ query: String,
        for locale: Locale
    ) -> Bool {
        matches(query, in: locale)
    }
}

extension EmojiCategory: CaseIterable {}

public extension EmojiCategory {
    
    @available(*, deprecated, message: "EmojiCategory will no longer implement CaseIterable")
    static var allCases: [EmojiCategory] {
        [
            .smileysAndPeople,
            .animalsAndNature,
            .foodAndDrink,
            .activity,
            .travelAndPlaces,
            .objects,
            .symbols,
            .flags
        ]
    }
    
    @available(*, deprecated, renamed: "standardWithoutRecent")
    static var standardWithoutFrequent: [EmojiCategory] { standardWithoutRecent }
}

public extension Collection where Element == Emoji {

    @available(*, deprecated, renamed: "matches(_:in:)")
    func matching(
        _ query: String,
        for locale: Locale
    ) -> [Emoji] {
        matching(query, in: locale)
    }
}

public extension Localizable {

    @available(*, deprecated, renamed: "localizedName(in:bundle:)")
    func localizedName(
        for locale: Locale = .current,
        in bundle: Bundle
    ) -> String {
        let key = localizationKey
        let localeBundle = bundle.bundle(for: locale) ?? bundle
        return NSLocalizedString(key, bundle: localeBundle, comment: "")
    }

    @available(*, deprecated, renamed: "localizedName(in:)")
    func localizedName(
        for locale: Locale = .current
    ) -> String {
        localizedName(in: locale)
    }
}
