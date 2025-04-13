//
//  EmojiCategory+LocalizationTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import XCTest
import EmojiKit

final class EmojiCategory_LocalizationTests: XCTestCase {
    
    func key(for cat: EmojiCategory) -> String {
        cat.localizationKey
    }
    
    func name(for cat: EmojiCategory) -> String {
        cat.localizedName
    }
    
    func name(for cat: EmojiCategory, locale: Locale) -> String {
        cat.localizedName(in: locale)
    }
    
    func testLocalizationKeyIsValid() {
        XCTAssertEqual(key(for: .smileysAndPeople), "EmojiCategory.smileysAndPeople")
        XCTAssertEqual(key(for: .animalsAndNature), "EmojiCategory.animalsAndNature")
        XCTAssertEqual(key(for: .foodAndDrink), "EmojiCategory.foodAndDrink")
        XCTAssertEqual(key(for: .activity), "EmojiCategory.activity")
        XCTAssertEqual(key(for: .travelAndPlaces), "EmojiCategory.travelAndPlaces")
        XCTAssertEqual(key(for: .objects), "EmojiCategory.objects")
        XCTAssertEqual(key(for: .symbols), "EmojiCategory.symbols")
        XCTAssertEqual(key(for: .flags), "EmojiCategory.flags")
    }
    
    func testLocalizedNameHasDefaultValue() {
        let current1 = name(for: .activity, locale: .current)
        XCTAssertEqual(name(for: .activity), current1)
        let current2 = name(for: .objects, locale: .current)
        XCTAssertEqual(name(for: .objects), current2)
    }
    
    func testLocalizedNameIsAvailableInEnglish() {
        let locale = Locale.english
        XCTAssertEqual(name(for: .smileysAndPeople, locale: locale), "Smileys & People")
        XCTAssertEqual(name(for: .animalsAndNature, locale: locale), "Animals & Nature")
        XCTAssertEqual(name(for: .foodAndDrink, locale: locale), "Food & Drink")
        XCTAssertEqual(name(for: .activity, locale: locale), "Activity")
        XCTAssertEqual(name(for: .travelAndPlaces, locale: locale), "Travel & Places")
        XCTAssertEqual(name(for: .objects, locale: locale), "Objects")
        XCTAssertEqual(name(for: .symbols, locale: locale), "Symbols")
        XCTAssertEqual(name(for: .flags, locale: locale), "Flags")
    }
    
    func testLocalizedNameIsAvailableInSwedish() {
        let locale = Locale.swedish
        XCTAssertEqual(name(for: .smileysAndPeople, locale: locale), "Smileys och människor")
        XCTAssertEqual(name(for: .animalsAndNature, locale: locale), "Djur och natur")
        XCTAssertEqual(name(for: .foodAndDrink, locale: locale), "Mat och dryck")
        XCTAssertEqual(name(for: .activity, locale: locale), "Aktivitet")
        XCTAssertEqual(name(for: .travelAndPlaces, locale: locale), "Resor och platser")
        XCTAssertEqual(name(for: .objects, locale: locale), "Objekt")
        XCTAssertEqual(name(for: .symbols, locale: locale), "Symboler")
        XCTAssertEqual(name(for: .flags, locale: locale), "Flaggor")
    }

    func testLocalizedNameIsAvailableInGerman() {
        let locale = Locale.german
        XCTAssertEqual(name(for: .smileysAndPeople, locale: locale), "Smileys & Menschen")
        XCTAssertEqual(name(for: .animalsAndNature, locale: locale), "Tiere & Natur")
        XCTAssertEqual(name(for: .foodAndDrink, locale: locale), "Essen & Trinken")
        XCTAssertEqual(name(for: .activity, locale: locale), "Aktivitäten")
        XCTAssertEqual(name(for: .travelAndPlaces, locale: locale), "Reisen & Orte")
        XCTAssertEqual(name(for: .objects, locale: locale), "Objekte")
        XCTAssertEqual(name(for: .symbols, locale: locale), "Symbole")
        XCTAssertEqual(name(for: .flags, locale: locale), "Flaggen")
    }

    func testLocalizedNameIsAvailableInItalian() {
        let locale = Locale.italian
        XCTAssertEqual(name(for: .smileysAndPeople, locale: locale), "Faccine & Persone")
        XCTAssertEqual(name(for: .animalsAndNature, locale: locale), "Animali & Natura")
        XCTAssertEqual(name(for: .foodAndDrink, locale: locale), "Cibo & Bevande")
        XCTAssertEqual(name(for: .activity, locale: locale), "Attività")
        XCTAssertEqual(name(for: .travelAndPlaces, locale: locale), "Viaggi & Luoghi")
        XCTAssertEqual(name(for: .objects, locale: locale), "Oggetti")
        XCTAssertEqual(name(for: .symbols, locale: locale), "Simboli")
        XCTAssertEqual(name(for: .flags, locale: locale), "Bandiere")
    }

    func testLocalizedNameIsAvailableInRussian() {
        let locale = Locale.russian
        XCTAssertEqual(name(for: .smileysAndPeople, locale: locale), "Смайлы и люди")
        XCTAssertEqual(name(for: .animalsAndNature, locale: locale), "Животные и природа")
        XCTAssertEqual(name(for: .foodAndDrink, locale: locale), "Еда и напитки")
        XCTAssertEqual(name(for: .activity, locale: locale), "Активности")
        XCTAssertEqual(name(for: .travelAndPlaces, locale: locale), "Путешествия и места")
        XCTAssertEqual(name(for: .objects, locale: locale), "Объекты")
        XCTAssertEqual(name(for: .symbols, locale: locale), "Символы")
        XCTAssertEqual(name(for: .flags, locale: locale), "Флаги")
    }

    func testLocalizedNameIsAvailableInFrench() {
        let locale = Locale.french
        XCTAssertEqual(name(for: .smileysAndPeople, locale: locale), "Émoticônes & Personnes")
        XCTAssertEqual(name(for: .animalsAndNature, locale: locale), "Animaux & Nature")
        XCTAssertEqual(name(for: .foodAndDrink, locale: locale), "Nourriture & Boissons")
        XCTAssertEqual(name(for: .activity, locale: locale), "Activité")
        XCTAssertEqual(name(for: .travelAndPlaces, locale: locale), "Voyages & Lieux")
        XCTAssertEqual(name(for: .objects, locale: locale), "Objets")
        XCTAssertEqual(name(for: .symbols, locale: locale), "Symboles")
        XCTAssertEqual(name(for: .flags, locale: locale), "Drapeaux")
    }

    func testLocalizedNameIsAvailableInJapanese() {
        let locale = Locale.japanese
        XCTAssertEqual(name(for: .smileysAndPeople, locale: locale), "笑顔と人")
        XCTAssertEqual(name(for: .animalsAndNature, locale: locale), "動物と自然")
        XCTAssertEqual(name(for: .foodAndDrink, locale: locale), "食べ物と飲み物")
        XCTAssertEqual(name(for: .activity, locale: locale), "活動")
        XCTAssertEqual(name(for: .travelAndPlaces, locale: locale), "旅行と場所")
        XCTAssertEqual(name(for: .objects, locale: locale), "物")
        XCTAssertEqual(name(for: .symbols, locale: locale), "記号")
        XCTAssertEqual(name(for: .flags, locale: locale), "旗")
    }

    func testLocalizedNameHasFallbackForUnsupportedLocales() {
        let emoji = Emoji("😀")
        XCTAssertEqual(
            emoji.localizedName(in: .finnish),
            emoji.localizedName(in: .current)
        )
    }
}
