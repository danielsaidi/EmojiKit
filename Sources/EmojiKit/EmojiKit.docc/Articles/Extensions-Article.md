# Extensions

This article describes EmojiKit's native type extensions.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

There are emoji-related extensions to native types, like ``Swift/String`` and ``Swift/Character``:

```swift
"Hello!".containsEmoji          // false
"Hello! 👋".containsEmoji       // true
"Hello! 👋".containsOnlyEmojis  // false
"👋".containsOnlyEmojis         // true
"Hello! 👋😀".emojis            // ["👋", "😀"]
"Hello! 👋😀".emojiString       // "👋😀"
"🫸🫷".isSingleEmoji            // false
"👍".isSingleEmoji              // true
```

These extensions power many features in the library, but can be used stand-alone utilifties as well.

EmojiKit also extends the native ``SwiftUI/ScrollViewProxy`` with ways to scroll to ``Emoji``, ``EmojiCategory``, and ``Emoji/GridSelection`` values.
