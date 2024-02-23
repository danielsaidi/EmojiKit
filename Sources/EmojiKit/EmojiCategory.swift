/*
//
//  EmojiCategory.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines standard emoji categories, as well as the
 emojis that belong to each category.
 
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

    /// An ordered list of all standard categories.
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

    /// An ordered list of all standard categories.
    static var all: [Element] { Element.all }
    
    /// Get the first category that has a certain ID.
    func firstCategory(withId id: Element.ID?) -> Element? {
        guard let id else { return nil }
        return first { $0.id == id }
    }
    
    /// Get the first category that has a certain emoji.
    func firstCategory(withEmoji emoji: Emoji?) -> Element? {
        guard let emoji else { return nil }
        return first { $0.hasEmoji(emoji) }
    }
}

public extension Emoji {
    
    /// Get a category specific ID for the emoji.
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
        let emojis = emojisStringInternal
            .replacingOccurrences(of: "\n", with: "")
            .compactMap {
                let emoji = Emoji(String($0))
                let isUnavailable = try? emoji.isUnavailable
                let result = isUnavailable ?? false
                return result ? nil : emoji
            }
        if !emojis.isEmpty, self != .frequent {
            Self.emojisInternalCache[self] = emojis
        }
        return emojis
    }
    
    /**
     Whether or not the category has any emojis.
     */
    var hasEmojis: Bool {
        !emojisInternal.isEmpty
    }
    
    /**
     The emoji category icon.
     
     > Important: Category icons require a Silver license or
     will otherwise throw an error.
     */
    var icon: Image {
        get throws {
            try .emojiCategory(self)
        }
    }
    
    /// The English title for the category.
    var title: String {
        localizedName
    }
    
    /**
     An emoji category label.
     
     > Important: Category icons require a Silver license or
     will otherwise throw an error.
     */
    var label: some View {
        Label {
            Text(title)
        } icon: {
            (try? icon) ?? Image(systemName: "exclamationmark.triangle")
        }
    }
}

extension EmojiCategory {
    
    /// Get the emoji at a certain index, if any.
    func emoji(at index: Int) -> Emoji? {
        let isValid = index >= 0 && index < emojisInternal.count
        return isValid ? emojisInternal[index] : nil
    }
    
    /// The first index of a certain index, if any.
    func firstIndex(of emoji: Emoji) -> Int? {
        emojisInternal.firstIndex {
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
    
    var emojisStringInternal: String {
        switch self {
        case .frequent: Self.frequentChars
        case .smileys: Self.smileysChars
        case .animals: Self.animalsChars
        case .food: Self.foodChars
        case .activities: Self.activitiesChars
        case .travels: Self.travelsChars
        case .objects: Self.objectsChars
        case .symbols: Self.symbolsChars
        case .flags: Self.flagsChars
            
        case .custom(_, _, let emojis, _): emojis
        }
    }
    
    static var frequentChars: String {
        Emoji.frequentEmojiProvider?.emojis
            .map { $0.char }
            .joined(separator: "") ?? ""
    }
}

#if os(iOS)
struct Emojis_Category_Previews: PreviewProvider {
    
    static var columns = [GridItem(.adaptive(minimum: 30))]
    
    static var previews: some View {
        let feature = Emoji.Feature.categoryInformation
        License.current = .init(licenseKey: "", tier: .gold)
        License.current = .init(licenseKey: "", tier: .silver, features: [feature])
        License.isSwiftUIPreviewAlwaysAllowed = false
        
        return ScrollView(.vertical) {
            VStack {
                ForEach(EmojiCategory.all) { cat in
                    VStack {
                        DisclosureGroup {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach((try? cat.emojis) ?? [.init("💸")]) {
                                        Text($0.char)
                                            .font(.title)
                                    }
                                }
                            }
                        } label: {
                            cat.label
                        }
                    }
                }.padding()
            }
        }
    }
}
#endif
*/
