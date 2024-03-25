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

There are emoji-related extensions to native types, like String and Character:

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



[GitHub]: https://github.com/Kankoda/EmojiKit
[Website]: https://kankoda.com/emojikit
