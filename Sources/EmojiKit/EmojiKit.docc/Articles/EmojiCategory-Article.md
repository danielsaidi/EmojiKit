# Emoji Category

This article describes the EmojiKit emoji category model.

EmojiKit has an ``EmojiCategory`` enum that defines all emoji categories, for instance:

```swift
try EmojiCategory.smileysAndPeople.emojis  // 😀😃😄...
try EmojiCategory.animalsAndNature.emojis  // 🐶🐱🐭...
```

You can use ``EmojiCategory/all`` to get a list of all available categories, in the default sort order:

```swift
EmojiCategory.all      // [.frequent, .smileyAndPeople, ...]
```

Categories use ``EmojiVersion`` to filter out emojis that are unavailable to the runtime.
