//
//  EmojiCategory.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines the standard emoji categories, as well as
 their emojis.
 
 The static ``EmojiCategory/all`` property provides you with
 all standard emoji categories. The ``EmojiCategory/frequent``
 category uses ``Emoji/frequentEmojiProvider`` to get a list
 of the most frequently used emojis to list in that category.
 */
public enum EmojiCategory: Codable, Equatable, Hashable, Identifiable {
    
    case
    frequent,
    smileysAndPeople,
    animalsAndNature,
    foodAndDrink,
    activity,
    travelAndPlaces,
    objects,
    symbols,
    flags,
    
    custom(
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
        "\(category.id).\(id)"
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
        case .custom(let id, _, _, _): id
        }
    }
    
    /// A list of all available emojis in the category.
    var emojis: [Emoji] {
        if let cached = Self.emojisCache[self] { return cached }
        let emojis = emojisString
            .replacingOccurrences(of: "\n", with: "")
            .compactMap {
                let emoji = Emoji(String($0))
                return emoji.isAvailableInCurrentRuntime ? emoji : nil
            }
        if self != .frequent {
            Self.emojisCache[self] = emojis
        }
        return emojis
    }
    
    /// Whether or not the category has any emojis.
    var hasEmojis: Bool {
        !emojis.isEmpty
    }
}

extension EmojiCategory {
    
    /// Get the emoji at a certain index, if any.
    func emoji(at index: Int) -> Emoji? {
        let isValid = index >= 0 && index < emojis.count
        return isValid ? emojis[index] : nil
    }
    
    /// The first index of a certain emoji, if any.
    func firstIndex(of emoji: Emoji) -> Int? {
        emojis.firstIndex {
            $0.neutralSkinToneVariant == emoji.neutralSkinToneVariant
        }
    }
    
    /// Whether or not the category contains a certain emoji.
    func hasEmoji(_ emoji: Emoji) -> Bool {
        firstIndex(of: emoji) != nil
    }
}

extension EmojiCategory {
    
    static var emojisCache = [EmojiCategory: [Emoji]]()
    
    var emojisString: String {
        switch self {
        case .frequent: Self.frequentChars
        case .smileysAndPeople: Self.smileysAndPeopleChars
        case .animalsAndNature: Self.animalsAndNatureChars
        case .foodAndDrink: Self.foodAndDrinkChars
        case .activity: Self.activityChars
        case .travelAndPlaces: Self.travelAndPlacesChars
        case .objects: Self.objectsChars
        case .symbols: Self.symbolsChars
        case .flags: Self.flagsChars
            
        case .custom(_, _, let emojis, _): emojis
        }
    }
    
    static var frequentChars: String {
        ""
        // TODO Emoji.frequentEmojiProvider?.emojis
        // TODO     .map { $0.char }
        // TODO     .joined(separator: "") ?? ""
    }
}

#if os(iOS)
struct Emojis_Category_Previews: PreviewProvider {
    
    static var columns = [GridItem(.adaptive(minimum: 30))]
    
    static var previews: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(EmojiCategory.all) { cat in
                    DisclosureGroup {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(cat.emojis) {
                                    Text($0.char)
                                        .font(.title)
                                }
                            }
                        }
                    } label: {
                        Text(cat.id)
                    }
                }.padding()
            }
        }
    }
}
#endif
