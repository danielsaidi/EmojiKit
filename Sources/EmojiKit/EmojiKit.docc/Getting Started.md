# Getting Started

This article describes how to get started with EmojiKit.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

EmojiKit is very easy to use. It's mostly based on very basic models, like ``Emoji`` and ``EmojiCategory``, which will provide you with all the information you need to create sophisticated emoji-based apps and software.



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

EmojiKit has an ``EmojiCategory`` enum that defines all standard emoji categories and their included emojis:

```swift
try EmojiCategory.smileysAndPeople.emojis  // 😀😃😄...
EmojiCategory.all      // [.frequent, .smileyAndPeople, ...]
```

You can read more in the <doc:EmojiCategory-Article> article.



## Emoji Versions

EmojiKit has an ``EmojiVersion`` type that defines all emoji versions, as well as their platform availability and included emojis:

```swift
let version = Emoji.Version.current
let v15 = Emoji.Version.v15
v15.emojis      // 🫨🫸🫷🪿🫎🪼🫏🪽🪻🫛🫚🪇🪈🪮🪭🩷🩵🩶🪯🛜
```

You can read more in the <doc:EmojiVersion-Article> article.



## Further Reading

@Links(visualStyle: detailedGrid) {
    
    - <doc:Emoji-Article>
    - <doc:EmojiCategory-Article>
    - <doc:EmojiVersion-Article>
    - <doc:Extensions-Article>
    - <doc:Localization-Article>
    - <doc:SkinTones-Article>
}
