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
        XCTAssertTrue(emoji.matches("GrIn", for: .english))
        XCTAssertTrue(emoji.matches("grIn", for: .swedish))
    }

    func testMatchesCaseInsensitiveLocalizedName() throws {
        XCTAssertTrue(emoji.matches("GrIn", for: .english))
        XCTAssertTrue(emoji.matches("lEende", for: .swedish))
    }
    
    func testCollectionMatchesEnglishQuery() throws {
        let emojiChars = "😀🥂😁🏬🤪🇪🇸🤩✅😸"
        let emojis = emojiChars.map { Emoji($0) }
        let result = emojis.matching("GrIn", for: .english)
        let chars = result.map { $0.char }.joined()
        XCTAssertEqual(chars, "😀😁🤪🤩😸")
    }
    
    func testCollectionMatchesMultipleQueryComponents() throws {
        let emojiChars = "😀🥂😁🏬🤪🇪🇸🤩✅😸"
        let emojis = emojiChars.map { Emoji($0) }
        let result = emojis.matching("eende ans", for: .swedish)
        let chars = result.map { $0.char }.joined()
        XCTAssertEqual(chars, "😀😁🤪🤩😸")
    }
}
