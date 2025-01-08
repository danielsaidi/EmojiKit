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
EmojiCategory.standard  // [.smileyAndPeople, .animalsAndNature, ...]
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

EmojiKit is currently only localized in `English` and `Swedish`, but anyone can contribute to provide support for more locales. See the `Sources/EmojiKit/Resources` folder for information on how to localize emojis and categories.



## Mutable Categories

Some ``EmojiCategory`` cases are mutable, and allows you to mutate their emojis:

* The ``EmojiCategory/favorites`` category uses the mutable ``EmojiCategory/favoriteEmojis`` collection.
* The ``EmojiCategory/frequent`` category uses the mutable ``EmojiCategory/frequentEmojis`` collection.
* The ``EmojiCategory/recent`` category uses the mutable ``EmojiCategory/recentEmojis`` collection.
* The ``EmojiCategory/custom(id:name:emojis:iconName:)`` category lets you create completely custom categories.

You can use ``EmojiCategory/addEmoji(_:to:maxCount:)``, ``EmojiCategory/removeEmoji(_:from:)`` and ``EmojiCategory/resetEmojis(in:)`` to affect a mutable category.

The ``EmojiGrid`` component will automatically update the ``EmojiCategory/frequent`` and ``EmojiCategory/recent`` categories when a user picks emojis in the grid. 

> Important: Since EmojiKit currently doesn't have an algoritm for frequency calculations, the ``EmojiCategory/frequent`` will currently be updated just like the ``EmojiCategory/recent`` category. You can however use the ``EmojiCategory/frequent`` category to implement your own frequency logic.



## Transferable

The ``EmojiCategory`` type conforms to the `Transferable` protocol, which means that it can use many native features like drag & drop, sharing, etc.

Make sure to specify that your app supports the ``UniformTypeIdentifiers/UTType/emojiCategory`` uniform type, to use these features.
