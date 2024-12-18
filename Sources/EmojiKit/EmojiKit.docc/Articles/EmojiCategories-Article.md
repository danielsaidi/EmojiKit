# Emoji Categories

This article describes the EmojiKit emoji category model.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

EmojiKit has an ``EmojiCategory`` enum that defines all available emoji categories and their emojis:

```swift
try EmojiCategory.smileysAndPeople.emojis  // 😀😃😄...
try EmojiCategory.animalsAndNature.emojis  // 🐶🐱🐭...
```

You can use the ``EmojiCategory/standard`` collection to get a list of all standard categories, in their standard sort order:

```swift
EmojiCategory.standard  // [.frequent, .smileyAndPeople, ...]
```

``EmojiCategory`` uses ``EmojiVersion`` to filter out emojis that are unavailable to the current runtime. This means that your users will only see emojis that they can use on their device and OS version.


## Localization

The ``EmojiCategory`` type can be localized in any locale that has defined translations:

```swift
let swedish = Locale(identifier: "sv")

let cat = EmojiCategory.animalsAndNature
cat.localizedName                        // Animals & Nature
cat.localizedName(in: .swedish)          // Djur och natur
```

EmojiKit is currently only localized in English, but anyone can contribute to provide support for more locales. See the `Sources/EmojiKit/Resources` folder for information on how to localize emojis.


## Persisted Categories

The ``EmojiCategory/frequent`` category returns the auto-persisted ``EmojiCategory/frequentEmojis`` collection, which you can get and set as you like. The same goes for the ``EmojiCategory/favorites`` category, which returns the auto-persisted ``EmojiCategory/favoriteEmojis`` collection.

You can use ``EmojiCategory/addEmoji(_:to:maxCount:)``, ``EmojiCategory/removeEmoji(_:from:)`` and ``EmojiCategory/resetEmojis(in:)`` to affect any persisted emoji category, and can even define custom categories if you need to.


## Transferable

The ``EmojiCategory`` type conforms to the `Transferable` protocol, which means that it can use many native features like drag & drop, sharing, etc.

Make sure to specify that your app supports the ``UniformTypeIdentifiers/UTType/emojiCategory`` uniform type, to use these features.
