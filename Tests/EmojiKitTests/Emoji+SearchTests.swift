//
//  Emoji+SearchTests.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2023-11-01.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class Emoji_SearchTests: XCTestCase {
    
    let emoji = Emoji("😀")
    
    func testMatchesCaseInsensitiveUnicodeName() throws {
        XCTAssertTrue(emoji.matches("GrIn", in: .english))
        XCTAssertTrue(emoji.matches("grIn", in: .swedish))
    }

    func testMatchesCaseInsensitiveLocalizedName() throws {
        XCTAssertTrue(emoji.matches("GrIn", in: .english))
        XCTAssertTrue(emoji.matches("lEende", in: .swedish))
    }
    
    func testCollectionMatchesEnglishQuery() throws {
        let emojiChars = "😀🥂😁🏬🤪🇪🇸🤩✅😸"
        let emojis = emojiChars.map { Emoji($0) }
        let result = emojis.matching("GrIn", in: .english)
        let chars = result.map { $0.char }.joined()
        XCTAssertEqual(chars, "😀😁🤪🤩😸")
    }

    func testCollectionMatchesMultipleQueryComponents() throws {
        let emojiChars = "😀🥂🤶😁🏬🧑‍🎄🤪🇪🇸🤩🎅✅😸"
        let emojis = emojiChars.map { Emoji($0) }
        let result = emojis.matching("sant", in: .english)
        let chars = result.map { $0.char }.joined()
        XCTAssertEqual(chars, "🤶🧑‍🎄🎅")
    }

    func testCollectionMatchesMultipleQueryComponentsLocalized() throws {
        let emojiChars = "😀🥂🤶😁🏬🧑‍🎄🤪🇪🇸🤩🎅✅😸"
        let emojis = emojiChars.map { Emoji($0) }
        let result = emojis.matching("tomt", in: .swedish)
        let chars = result.map { $0.char }.joined()
        XCTAssertEqual(chars, "🤶🧑‍🎄🎅")
    }
}
