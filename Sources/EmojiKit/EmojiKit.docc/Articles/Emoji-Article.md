# Emoji

This article describes the EmojiKit ``Emoji`` model.

EmojiKit has an ``Emoji`` struct that lets you work with emojis in a structured way:

```swift
let emoji = Emoji("😀")
```

This type has unicode-specific properties that are used for identity and naming:

```swift
Emoji("👍").unicodeIdentifier   // \\N{THUMBS UP SIGN}
Emoji("👍🏿").unicodeIdentifier   // \\N{THUMBS UP SIGN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-6}
Emoji("🚀").unicodeIdentifier   // \\N{ROCKET}
Emoji("👍").unicodeName         // Thumbs Up Sign
Emoji("👍🏿").unicodeName         // Thumbs Up Sign
Emoji("🚀").unicodeName         // Rocket
```

You can use ``Emoji/all`` to get a list of all emojis from all categories, that are available to the currently exeucting runtime:

```swift
let emojis = Emoji.all          // 😀😃😄😁😆🥹😅😂🤣🥲...
```

The ``Emoji`` type also serves as a namespace for most EmojiKit features, which means that most types are wrapped within this struct.



[GitHub]: https://github.com/Kankoda/EmojiKit
[Website]: https://kankoda.com/emojikit
