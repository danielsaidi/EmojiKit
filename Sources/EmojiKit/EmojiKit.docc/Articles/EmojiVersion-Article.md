# Emoji Version

This article describes the EmojiKit emoji version model.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

EmojiKit has an ``EmojiVersion`` type that defines all currently available Emoji versions, their platform availability and included emojis.


## How to access emoji versions

You can use ``EmojiVersion/current`` to get the latest available emoji version for the current runtime:

```swift
let version = EmojiVersion.current
```

You can also get specific emoji versions, for instance:

```swift
let v15 = EmojiVersion.v15
let v14 = EmojiVersion.v14
```

You can also get the emoji version supported by a certain OS version, for instance:

```swift
EmojiVersion(iOS: 15.4).version    // 14.0
EmojiVersion(macOS: 11.1).version  // 13.0
```

This lets you figure out exactly which version you can use for a certain OS and platform version. EmojiKit uses this information to make categories only return the emojis that are available to the current runtime.


## Version Information

An emoji version defines in which OS versions it became available:

```swift
let version = EmojiVersion.v15
version.version  // 15.0
version.iOS      // 16.4
version.macOS    // 13.3
version.tvOS     // 16.4
version.watchOS  // 9.4
```

An emoji version also defines all emojis that were introduced in that version, as well as older and later emoji versions:

```swift
let version = EmojiVersion.v14
version.emojis            // 🫠🫢🫣🫡🫥🫤🥹...
version.laterVersions     // [.v15]
version.olderVersions     // [.v13_1, .v13, .v12_1, ...]
```

This lets the emoji version specify unavailable emojis, that were introduced in later versions:

```swift
version.unavailableEmojis // 🫨🫸🫷🪿🫎🪼🫏🪽...
```

This information can be used to filter out unavailable emojis from the various categories.
