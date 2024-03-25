# Emoji Category

This article describes the EmojiKit emoji category model.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

EmojiKit has an ``EmojiCategory`` enum that defines all available emoji categories and their included emojis:

```swift
try EmojiCategory.smileysAndPeople.emojis  // 😀😃😄...
try EmojiCategory.animalsAndNature.emojis  // 🐶🐱🐭...
```

You can use ``EmojiCategory/all`` to get a list of all available categories, in the native, default sort order:

```swift
EmojiCategory.all      // [.frequent, .smileyAndPeople, ...]
```

``EmojiCategory`` uses ``EmojiVersion`` to filter out emojis that are unavailable to the runtime, which means that your users will only see emojis they can use.
