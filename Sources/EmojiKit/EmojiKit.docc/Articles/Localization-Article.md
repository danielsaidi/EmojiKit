# Localization

This article describes the EmojiKit localization engine.

EmojiKit supports localizing emojis:

```swift
Emoji("😀").localizedName                   // Grinning Face
Emoji("😀").localizedName(for: .english)    // Grinning Face
Emoji("😀").localizedName(for: .swedish)    // Leende Ansikte
```

as well as categories:

```swift
let cat = EmojiCategory.animalsAndNature
cat.localizedName                   // Animals & Nature
cat.localizedName(for: .english)    // Animals & Nature
cat.localizedName(for: .swedish)    // Djur och natur
```


## How to localize EmojiKit for more locales

EmojiKit is currently only localized in English, but anyone can contribute to provide more locales.

To translate EmojiKit, just copy any `.lproj` folder in `Sources/EmojiKit/Resources` and translate the `Localizable.strings` file to any locale.
