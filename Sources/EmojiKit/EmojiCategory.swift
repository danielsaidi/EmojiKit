//
//  EmojiCategory.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum defines the standard emoji categories, as well
/// as their emojis.
///
/// The static ``EmojiCategory/all`` property can be used to
/// get all standard categories.
///
/// The ``EmojiCategory/frequent`` category is a placeholder
/// that defines an ``id``, ``title``, ``icon`` etc. for the
/// category. The category however has no emojis, since that
/// would require a single list, which is unflexible.
///
/// Instead, use a ``FequentEmojiProvider`` to get a list of
/// frequently used emojis and present them for the category.
/// Then call ``FrequentEmojiProvider/registerEmoji(_:)`` to
/// automatically update this category when an emoji is used.
///
/// Various EmojiKit views, like the ``EmojiGrid``, lets you
/// pass in a custom provider, and will automatically use it
/// to register emojis when the user interacts with an emoji.
public enum EmojiCategory: Codable, Equatable, Hashable, Identifiable {
    
    case frequent
    case smileysAndPeople
    case animalsAndNature
    case foodAndDrink
    case activity
    case travelAndPlaces
    case objects
    case symbols
    case flags

    case search(query: String)

    case custom(
        id: String,
        name: String,
        emojis: String = "",
        iconName: String = ""
    )
}

public extension EmojiCategory {

    /// Get an ordered list of all standard categories.
    static var all: [EmojiCategory] {
        [
            .frequent,
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
}

public extension Array where Element == EmojiCategory {

    /// Get the category after the provided category.
    func category(after category: Element) -> Element? {
        guard let index = firstIndex(of: category) else { return nil }
        let newIndex = index + 1
        return newIndex < count ? self[newIndex] : nil
    }

    /// Get the category before the provided category.
    func category(before category: Element) -> Element? {
        guard let index = firstIndex(of: category) else { return nil }
        let newIndex = index - 1
        return newIndex >= 0 ? self[newIndex] : nil
    }
}

public extension Collection where Element == EmojiCategory {

    /// Get an ordered list of all standard categories.
    static var all: [Element] { Element.all }
    
    /// Get the first category with a certain ID.
    func category(withId id: Element.ID?) -> Element? {
        guard let id else { return nil }
        return first { $0.id == id }
    }
    
    /// Get the first category with a certain emoji.
    func category(withEmoji emoji: Emoji?) -> Element? {
        guard let emoji else { return nil }
        return first { $0.hasEmoji(emoji) }
    }
}

public extension Emoji {
    
    /// The emoji's unique identifier with a category prefix.
    ///
    /// This can be used to get a unique identifier for each
    /// category, e.g. when listing multiple categories that
    /// can contain the same emoji.
    func id(in category: EmojiCategory) -> String {
        if category.id.isEmpty { return id }
        return "\(category.id).\(id)"
    }
}

public extension EmojiCategory {
    
    /// The category's unique identifier.
    var id: String {
        switch self {
        case .frequent: "frequent"
        case .smileysAndPeople: "smileysAndPeople"
        case .animalsAndNature: "animalsAndNature"
        case .foodAndDrink: "foodAndDrink"
        case .activity: "activity"
        case .travelAndPlaces: "travelAndPlaces"
        case .objects: "objects"
        case .symbols: "symbols"
        case .flags: "flags"

        case .search: "search"
        case .custom(let id, _, _, _): id
        }
    }
    
    /// An emoji-based icon that represents the category.
    var emojiIcon: String {
        switch self {
        case .frequent: "🕘"
        case .smileysAndPeople: "😀"
        case .animalsAndNature: "🐻"
        case .foodAndDrink: "🍔"
        case .activity: "⚽️"
        case .travelAndPlaces: "🏢"
        case .objects: "💡"
        case .symbols: "💱"
        case .flags: "🏳️"

        case .search: "🔍"
        case .custom: "-"
        }
    }
    
    /// A list of all available emojis in the category.
    var emojis: [Emoji] {
        switch self {
        case .frequent: []
        case .smileysAndPeople: Self.emojisForSmileysAndPeople
        case .animalsAndNature: Self.emojisForAnimalsAndNature
        case .foodAndDrink: Self.emojisForFoodAndDrink
        case .activity: Self.emojisForActivity
        case .travelAndPlaces: Self.emojisForTravelAndPlaces
        case .objects: Self.emojisForObjects
        case .symbols: Self.emojisForSymbols
        case .flags: Self.emojisForFlags

        case .search(let query): Emoji.all.matching(query)
        case .custom: emojiStringEmojis
        }
    }
    
    /// Whether or not the category has any emojis.
    var hasEmojis: Bool {
        !emojis.isEmpty
    }
}

extension EmojiCategory {
    
    var emojiString: String {
        switch self {
        case .frequent: ""
        case .smileysAndPeople: Self.smileysAndPeopleChars
        case .animalsAndNature: Self.animalsAndNatureChars
        case .foodAndDrink: Self.foodAndDrinkChars
        case .activity: Self.activityChars
        case .travelAndPlaces: Self.travelAndPlacesChars
        case .objects: Self.objectsChars
        case .symbols: Self.symbolsChars
        case .flags: Self.flagsChars

        case .search: ""
        case .custom(_, _, let emojis, _): emojis
        }
    }
    
    var emojiStringEmojis: [Emoji] {
        emojiString
            .replacingOccurrences(of: "\n", with: "")
            .compactMap {
                let emoji = Emoji(String($0))
                return emoji.isAvailableInCurrentRuntime ? emoji : nil
            }
    }
    
    /// Whether or not the category contains a certain emoji.
    func hasEmoji(_ emoji: Emoji) -> Bool {
        emojis.firstIndex(of: emoji) != nil
    }
}

extension EmojiCategory {
    
    static let emojisForSmileysAndPeople: [Emoji] = {
        EmojiCategory.smileysAndPeople.emojiStringEmojis
    }()

    static let emojisForAnimalsAndNature: [Emoji] = {
        EmojiCategory.animalsAndNature.emojiStringEmojis
    }()

    static let emojisForFoodAndDrink: [Emoji] = {
        EmojiCategory.foodAndDrink.emojiStringEmojis
    }()

    static let emojisForActivity: [Emoji] = {
        EmojiCategory.activity.emojiStringEmojis
    }()

    static let emojisForTravelAndPlaces: [Emoji] = {
        EmojiCategory.travelAndPlaces.emojiStringEmojis
    }()

    static let emojisForObjects: [Emoji] = {
        EmojiCategory.objects.emojiStringEmojis
    }()

    static let emojisForSymbols: [Emoji] = {
        EmojiCategory.symbols.emojiStringEmojis
    }()

    static let emojisForFlags: [Emoji] = {
        EmojiCategory.flags.emojiStringEmojis
    }()

    static let emojisForSmileys: [Emoji] = {
        EmojiCategory.smileysAndPeople.emojiStringEmojis
    }()
}

#if os(iOS) || os(macOS)
#Preview {
    
    struct Preview: View {
        
        var columns = [GridItem(.adaptive(minimum: 30))]
        
        var body: some View {
            NavigationView {
                #if os(macOS)
                Color.clear
                #endif
                
                ScrollView(.vertical) {
                    VStack {
                        ForEach(EmojiCategory.all) { cat in
                            DisclosureGroup {
                                EmojiGrid(
                                    emojis: cat.emojis,
                                    section: { $0.view },
                                    item: { $0.view }
                                )
                                .padding(.top)
                            } label: {
                                Label {
                                    Text(cat.localizedName)
                                } icon: {
                                    Text(cat.emojiIcon)
                                }
                            }
                            
                            Divider()
                        }
                    }
                    .padding()
                }
                .navigationTitle("Emoji Category")
            }
        }
    }
    
    return Preview()
}
#endif
