# Localization

This article describes the EmojiKit localization engine.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

``Emoji`` can be localized in any supported locale that has defined translations:

```swift
let english = Locale(identifier: "en-US")
let swedish = Locale(identifier: "sv")

Emoji("😀").localizedName                 // Grinning Face
Emoji("😀").localizedName(for: .english)  // Grinning Face
Emoji("😀").localizedName(for: .swedish)  // Leende Ansikte
```

Youc an also get the localized name of any emoji category:

```swift
let cat = EmojiCategory.animalsAndNature
cat.localizedName                         // Animals & Nature
cat.localizedName(for: .english)          // Animals & Nature
cat.localizedName(for: .swedish)          // Djur och natur
```

EmojiKit is currently only localized in English, but anyone can contribute to provide support for more locales.


## How to localize EmojiKit for more locales

To add support for a new locale, just copy any `.lproj` folder in `Sources/EmojiKit/Resources` and translate `Localizable.strings` to the new locale.
