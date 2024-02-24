# Emoji

This article describes the EmojiKit emoji model.

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

The ``Emoji`` type is also extended with more capabilities, such as <doc:Localization-Article> and <doc:SkinTones-Article>.



[GitHub]: https://github.com/Kankoda/EmojiKit
[Website]: https://kankoda.com/emojikit
