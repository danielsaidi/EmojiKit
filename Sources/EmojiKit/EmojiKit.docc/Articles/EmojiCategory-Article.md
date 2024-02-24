# Emoji Category

This article describes the EmojiKit ``EmojiCategory`` model.

EmojiKit has an ``EmojiCategory`` enum that defines all standard emoji categories, for instance:

```swift
try EmojiCategory.smileysAndPeople.emojis  // 😀😃😄...
try EmojiCategory.animalsAndNature.emojis  // 🐶🐱🐭...
```

You can use ``EmojiCategory/all`` to get a list of all available categories:

```swift
EmojiCategory.all      // [.frequent, .smileyAndPeople, ...]
```

Categories use the ``EmojiVersion`` information to filter out emojis that are unavailable to the runtime.
