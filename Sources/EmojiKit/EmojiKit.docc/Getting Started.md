# Getting started

This article describes how to get started with EmojiKit.



## Emojis

EmojiKit has an ``Emoji`` struct that lets you work with emojis in a structured way:

```swift
let emoji = Emoji("😀")
let emojis = Emoji.all          // 😀😃😄😁😆🥹😅😂🤣🥲...
```

The ``Emoji`` type has unicode properties, for instance:

```swift
Emoji("👍").unicodeIdentifier   // \\N{THUMBS UP SIGN}
```

You can read more in the <doc:Emoji-Article> article.



## Emoji Categories

EmojiKit has an ``EmojiCategory`` struct that defines all standard emoji categories:

```swift
try EmojiCategory.smileysAndPeople.emojis  // 😀😃😄...
EmojiCategory.all      // [.frequent, .smileyAndPeople, ...]
```

You can read more in the <doc:EmojiCategory-Article> article.



## Emoji Versions

EmojiKit has an ``EmojiVersion`` type that defines Emoji versions, and their platform availability and included emojis:

```swift
let version = Emoji.Version.current
let v15 = Emoji.Version.v15
```

An emoji version defines in which OS version it was released, and what emojis that was released in that version.

You can read more in the <doc:EmojiVersion-Article> article.



## Read More 

See the various articles for more information, such as <doc:Extensions-Article>, <doc:Localization-Article> and <doc:SkinTones-Article>.
