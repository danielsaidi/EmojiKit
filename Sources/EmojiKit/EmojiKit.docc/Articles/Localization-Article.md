# Localization

This article describes the EmojiKit localization engine.

EmojiKit supports localizing emojis:

```swift
Emoji("😀").localizedName                   // Grinning Face
Emoji("😀").localizedName(for: .english)    // Grinning Face
Emoji("😀").localizedName(for: .swedish)    // Leende Ansikte
```

as well as emoji categories:

```swift
let cat = EmojiCategory.animalsAndNature
cat.localizedName                   // Animals & Nature
cat.localizedName(for: .english)    // Animals & Nature
cat.localizedName(for: .swedish)    // Djur och natur
```


## How to localize EmojiKit for more locales

EmojiKit is currently only localized in English, but you can contribute to localize it for more locales.

To add localization for a new locale, just copy the English `.lproj` folder and translate the content to any locale.
