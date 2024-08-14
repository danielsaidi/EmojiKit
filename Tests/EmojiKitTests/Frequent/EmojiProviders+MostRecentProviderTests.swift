//
//  EmojiProviders+MostRecentProvider.swift
//  EmojiKitTests
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class EmojiProviders_MostRecentProviderTests: XCTestCase {

    var defaults: UserDefaults!
    var provider: EmojiProviders.MostRecentProvider!

    let key = String.mostRecentPersistencyKey

    override func setUp() {
        defaults = UserDefaults.standard
        provider = .init(defaults: defaults)
    }
    
    override func tearDown() {
        defaults.removeObject(forKey: key)
    }

    func testMostRecentEmojisIsEmptyByDefault() {
        XCTAssertEqual(provider.emojis, [])
    }
    
    func testMostRecentEmojisReturnsDataFromUserDefaults() {
        let list = ["a", "b", "c"]
        defaults.set(list, forKey: key)
        XCTAssertEqual(provider.emojis.map { $0.char }, list)
    }
    
    func testMostRecentEmojisPlacesExistingEmojisFirst() {
        let list = ["a", "b", "c"]
        defaults.set(list, forKey: key)
        provider?.addEmoji(Emoji("c"))
        XCTAssertEqual(provider.emojis.map { $0.char }, ["c", "a", "b"])
    }
    
    func testMostRecentEmojisPlacesNewEmojiFirst() {
        let list = ["a", "b", "c"]
        defaults.set(list, forKey: key)
        provider?.addEmoji(Emoji("d"))
        XCTAssertEqual(provider.emojis.map { $0.char }, ["d", "a", "b", "c"])
    }
    
    func testMostRecentEmojisCapsToMaxCount() {
        let data = (0...100).map { String($0) }
        defaults.set(data, forKey: key)
        provider?.addEmoji(Emoji("d"))
        let emojis = provider.emojis.map { $0.char }
        XCTAssertEqual(emojis.first, "d")
        XCTAssertEqual(emojis.prefix(5), ["d", "0", "1", "2", "3"])
    }
}
