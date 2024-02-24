# Extensions

This article describes extensions that EmojiKit provides.

EmojiKit has emoji-related String and Character extensions, for instance:

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

These extensions power many features in the library, but can be used stand-alone as well.



[GitHub]: https://github.com/Kankoda/EmojiKit
[Website]: https://kankoda.com/emojikit
