# Extensions

This article describes extensions that EmojiKit provides.

EmojiKit has String and Character extensions that can be used to detect and handle emojis, for instance:

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

These extensions are used to power many features in the library, but can be used stand-alone as well.



[GitHub]: https://github.com/Kankoda/EmojiKit
[Website]: https://kankoda.com/emojikit
