//
//  EmojiCategory.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum defines the standard emoji categories, as well as their emojis.
///
/// The ``persisted(_:)`` category uses a ``Persisted`` category type
/// that defines special categories to which you can add and remove emojis.
///
/// Use the ``custom(id:name:emojis:iconName:)`` to create a custom
/// category with static emojis.
public enum EmojiCategory: Codable, Equatable, Hashable, Identifiable, Sendable {

    case smileysAndPeople
    case animalsAndNature
    case foodAndDrink
    case activity
    case travelAndPlaces
    case objects
    case symbols
    case flags
    
    case custom(
        id: String,
        name: String,
        emojis: [Emoji],
        iconName: String = ""
    )
}

extension EmojiCategory: Transferable {

    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .emojiCategory)
        ProxyRepresentation(exporting: \.emojisString)
    }
}

public extension EmojiCategory {

    /// A persisted favorites category.
    static var favorites: EmojiCategory {
        .persisted(.favorites)
    }

    /// A persisted frequent category.
    static var frequent: EmojiCategory {
        .persisted(.frequent)
    }

    /// A persisted recent category.
    static var recent: EmojiCategory {
        .persisted(.recent)
    }

    /// A custom, persisted category.
    static func persisted(
        _ category: Persisted
    ) -> EmojiCategory {
        .custom(
            id: category.id,
            name: category.name,
            emojis: category.getEmojis(),
            iconName: category.iconName
        )
    }
    
    /// A custom category with an emoji search result.
    static func search(
        query: String
    ) -> EmojiCategory {
        .custom(
            id: "search",
            name: "Search",
            emojis: Emoji.all.matching(query),
            iconName: "search"
        )
    }
}

public extension EmojiCategory {
    
    /// A list with all standard emoji categories, sorted by the order in which they
    /// appear on Apple platforms.
    ///
    /// This list doesn't contain the ``frequent`` or ``recent`` categories,
    /// only the standard, fixed categories.
    static let standardCategories: [EmojiCategory] = {
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
    }()
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

    /// Get an ordered list of all standard categories, with
    /// no ``EmojiCategory/frequent`` emojis firstmost.
    static var standard: [Element] { Element.standardCategories }

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
    
    /// The emoji's unique identifier to use within a certain category.
    func id(in category: EmojiCategory) -> String {
        if category.id.isEmpty { return id }
        return "\(category.id).\(id)"
    }
}

public extension EmojiCategory {
    
    /// The category's unique identifier.
    var id: String {
        switch self {
        case .smileysAndPeople: "smileysAndPeople"
        case .animalsAndNature: "animalsAndNature"
        case .foodAndDrink: "foodAndDrink"
        case .activity: "activity"
        case .travelAndPlaces: "travelAndPlaces"
        case .objects: "objects"
        case .symbols: "symbols"
        case .flags: "flags"
        case .custom(let id, _, _, _): id
        }
    }
    
    /// An SF Symbol-based icon for the category.
    var symbolIcon: Image {
        switch self {
        case .smileysAndPeople: .init(systemName: "face.smiling")
        case .animalsAndNature: .init(systemName: "teddybear")
        case .foodAndDrink: .init(systemName: "fork.knife")
        case .activity: .init(systemName: "soccerball")
        case .travelAndPlaces: .init(systemName: "car")
        case .objects: .init(systemName: "lightbulb")
        case .symbols: .init(systemName: "heart")
        case .flags: .init(systemName: "flag")
        case .custom(_, _, _, let iconName):  .init(systemName: iconName)
        }
    }
    
    /// A list of all available emojis in the category.
    var emojis: [Emoji] {
        switch self {
        case .smileysAndPeople: Self.emojisForSmileysAndPeople
        case .animalsAndNature: Self.emojisForAnimalsAndNature
        case .foodAndDrink: Self.emojisForFoodAndDrink
        case .activity: Self.emojisForActivity
        case .travelAndPlaces: Self.emojisForTravelAndPlaces
        case .objects: Self.emojisForObjects
        case .symbols: Self.emojisForSymbols
        case .flags: Self.emojisForFlags
        case .custom(_, _, let emojis, _): emojis
        }
    }
    
    /// A list of all available emojis in the category, as a concatenated string.
    var emojisString: String {
        emojis.map { $0.char }.joined()
    }
    
    /// Whether or not the category has any emojis.
    var hasEmojis: Bool {
        !emojis.isEmpty
    }
}

extension EmojiCategory {
    
    /// Whether or not the category contains a certain emoji.
    func hasEmoji(_ emoji: Emoji) -> Bool {
        emojis.firstIndex(of: emoji) != nil
    }
}

private extension String {
    
    func parseEmojis() -> [Emoji] {
        self.replacingOccurrences(of: "\n", with: "")
            .compactMap {
                let emoji = Emoji(String($0))
                return emoji.isAvailableInCurrentRuntime ? emoji : nil
            }
    }
}

/// A category cache layer to avoid parsing emojis each time.
extension EmojiCategory {
    
    static let emojisForSmileysAndPeople: [Emoji] = {
        smileysAndPeopleChars.parseEmojis()
    }()

    static let emojisForAnimalsAndNature: [Emoji] = {
        animalsAndNatureChars.parseEmojis()
    }()

    static let emojisForFoodAndDrink: [Emoji] = {
        foodAndDrinkChars.parseEmojis()
    }()

    static let emojisForActivity: [Emoji] = {
        activityChars.parseEmojis()
    }()

    static let emojisForTravelAndPlaces: [Emoji] = {
        travelAndPlacesChars.parseEmojis()
    }()

    static let emojisForObjects: [Emoji] = {
        objectsChars.parseEmojis()
    }()

    static let emojisForSymbols: [Emoji] = {
        symbolsChars.parseEmojis()
    }()

    static let emojisForFlags: [Emoji] = {
        flagsChars.parseEmojis()
    }()

    static let emojisForSmileys: [Emoji] = {
        smileysAndPeopleChars.parseEmojis()
    }()
}

#Preview {

    func categories() -> [EmojiCategory] { .standard }

    /// This preview limits each line to 5 emojis to simplify compareing columns
    /// with the native iOS keyboard.
    return NavigationView {
        List {
            ForEach(categories()) { cat in
                NavigationLink {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: [GridItem].init(repeating: .init(.fixed(60)), count: 5)) {
                            ForEach(cat.emojis) {
                                Text($0.char)
                                    .font(.largeTitle)
                            }
                        }
                    }
                } label: {
                    Label {
                        Text(cat.localizedName)
                    } icon: {
                        Text(cat.symbolIcon)
                    }
                }
            }
        }
        .navigationTitle("Emoji Categories")
    }
}
