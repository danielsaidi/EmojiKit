//
//  EmojiVersionTests.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-01.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import EmojiKit
import XCTest

final class Emoji_VersionTests: XCTestCase {
    
    func testDefinesVersion15() throws {
        let version = EmojiVersion.v15
        let emojis = version.emojis.map { $0.char }
        XCTAssertTrue(emojis.contains("🫨"))
        XCTAssertTrue(emojis.contains("🫸"))
        XCTAssertTrue(emojis.contains("🫸🏻"))
        XCTAssertEqual(version.version, 15.0)
        XCTAssertEqual(version.iOS, 16.4)
        XCTAssertEqual(version.macOS, 13.3)
        XCTAssertEqual(version.tvOS, 16.4)
        XCTAssertEqual(version.watchOS, 9.4)
    }

    func testDefinesVersion14() throws {
        let version = EmojiVersion.v14
        let emojis = version.emojis.map { $0.char }
        XCTAssertTrue(emojis.contains("🫠"))
        XCTAssertTrue(emojis.contains("🫱"))
        XCTAssertTrue(emojis.contains("🫱🏿"))
        XCTAssertEqual(version.version, 14.0)
        XCTAssertEqual(version.iOS, 15.4)
        XCTAssertEqual(version.macOS, 12.3)
        XCTAssertEqual(version.tvOS, 15.4)
        XCTAssertEqual(version.watchOS, 8.5)
    }

    func testDefinesVersion13_1() throws {
        let version = EmojiVersion.v13_1
        let emojis = version.emojis.map { $0.char }
        XCTAssertTrue(emojis.contains("🧔🏿‍♀️"))
    }

    func testDefinesVersion13() throws {
        let version = EmojiVersion.v13
        let emojis = version.emojis.map { $0.char }
        XCTAssertTrue(emojis.contains("🤌🏾"))
    }

    func testDefinesVersion12_1() throws {
        let version = EmojiVersion.v12_1
        let emojis = version.emojis.map { $0.char }
        XCTAssertTrue(emojis.contains("🧑‍🦰"))
    }

    func testDefinesVersion12() throws {
        let version = EmojiVersion.v12
        let emojis = version.emojis.map { $0.char }
        XCTAssertTrue(emojis.contains("🤏🏽"))
    }

    func testCanBeCreatedForIOS() throws {
        XCTAssertNil(EmojiVersion(iOS: 11.0))
        XCTAssertEqual(EmojiVersion(iOS: 11.1)?.version, 11)
        XCTAssertEqual(EmojiVersion(iOS: 12.0)?.version, 11)
        XCTAssertEqual(EmojiVersion(iOS: 12.1)?.version, 12.1)
        XCTAssertEqual(EmojiVersion(iOS: 14.2)?.version, 13)
        XCTAssertEqual(EmojiVersion(iOS: 14.5)?.version, 13.1)
        XCTAssertEqual(EmojiVersion(iOS: 15.4)?.version, 14)
        XCTAssertEqual(EmojiVersion(iOS: 16.3)?.version, 14)
        XCTAssertEqual(EmojiVersion(iOS: 16.5)?.version, 15)
    }

    func testCanBeCreatedForMacOS() throws {
        XCTAssertNil(EmojiVersion(macOS: 10.0))
        XCTAssertEqual(EmojiVersion(macOS: 10.13)?.version, 11)
        XCTAssertEqual(EmojiVersion(macOS: 10.14)?.version, 12.1)
        XCTAssertEqual(EmojiVersion(macOS: 11.1)?.version, 13)
        XCTAssertEqual(EmojiVersion(macOS: 11.3)?.version, 13.1)
        XCTAssertEqual(EmojiVersion(macOS: 12.3)?.version, 14)
        XCTAssertEqual(EmojiVersion(macOS: 12.3)?.version, 14)
        XCTAssertEqual(EmojiVersion(macOS: 13.3)?.version, 15)
    }

    func testCanBeCreatedForTvOS() throws {
        XCTAssertNil(EmojiVersion(tvOS: 11.0))
        XCTAssertEqual(EmojiVersion(tvOS: 11.1)?.version, 11)
        XCTAssertEqual(EmojiVersion(tvOS: 12.0)?.version, 11)
        XCTAssertEqual(EmojiVersion(tvOS: 12.1)?.version, 12.1)
        XCTAssertEqual(EmojiVersion(tvOS: 14.2)?.version, 13)
        XCTAssertEqual(EmojiVersion(tvOS: 14.5)?.version, 13.1)
        XCTAssertEqual(EmojiVersion(tvOS: 15.4)?.version, 14)
        XCTAssertEqual(EmojiVersion(tvOS: 16.3)?.version, 14)
        XCTAssertEqual(EmojiVersion(tvOS: 16.5)?.version, 15)
    }

    func testCanBeCreatedForWatchOS() throws {
        XCTAssertNil(EmojiVersion(watchOS: 4.0))
        XCTAssertEqual(EmojiVersion(watchOS: 4.1)?.version, 11)
        XCTAssertEqual(EmojiVersion(watchOS: 5.1)?.version, 12.1)
        XCTAssertEqual(EmojiVersion(watchOS: 7.1)?.version, 13)
        XCTAssertEqual(EmojiVersion(watchOS: 7.4)?.version, 13.1)
        XCTAssertEqual(EmojiVersion(watchOS: 8.5)?.version, 14)
        XCTAssertEqual(EmojiVersion(watchOS: 8.6)?.version, 14)
        XCTAssertEqual(EmojiVersion(watchOS: 9.4)?.version, 15)
    }

    func testCanSpecifyOlderAndLaterVersions() throws {
        XCTAssertEqual(EmojiVersion.v14.olderVersions, [.v11, .v12, .v12_1, .v13, .v13_1])
        XCTAssertEqual(EmojiVersion.v14.laterVersions, [.v15])
        XCTAssertEqual(EmojiVersion.v15.olderVersions, [.v11, .v12, .v12_1, .v13, .v13_1, .v14])
        XCTAssertEqual(EmojiVersion.v15.laterVersions, [])
    }
    
    func testCanSpecifyUnavailableEmojis() throws {
        let v14 = EmojiVersion.v14.unavailableEmojis.map { $0.char }
        let v15 = EmojiVersion.v15.unavailableEmojis.map { $0.char }
        XCTAssertFalse(v14.contains("🫠"))
        XCTAssertTrue(v14.contains("🫨"))
        XCTAssertFalse(v15.contains("🫠"))
        XCTAssertFalse(v15.contains("🫨"))
    }
    
    func testCurrentIsTheLatestOne() throws {
        XCTAssertEqual(EmojiVersion.current, .v15)
    }
    
    func testCurrentUnavailableEmojisIsEmpty() throws {
        XCTAssertEqual(EmojiVersion.currentUnavailableEmojis, [])
        XCTAssertEqual(EmojiVersion.currentUnavailableEmojis.count, 0)
    }
    
    func testCanCheckIfEmojiIsAvailableInCurrentVersion() {
        XCTAssertTrue(Emoji("💯").isAvailableInCurrentRuntime)
        XCTAssertFalse(Emoji("💯").isUnavailableInCurrentRuntime)
    }
}
