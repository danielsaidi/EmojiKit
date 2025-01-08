# Emojis

This article describes the EmojiKit emoji model.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

EmojiKit has an ``Emoji`` struct that lets you work with emojis in a structured way:

```swift
let emoji = Emoji("😀")
```

You can use ``Emoji/all`` to get a list of all available emojis from all standard ``EmojiCategory`` values:

```swift
let emojis = Emoji.all          // 😀😃😄😁😆🥹😅😂🤣🥲...
```

You can also get emojis for a specific category and version. See the <doc:EmojiCategories-Article> and <doc:EmojiVersions-Article> articles for more information.


## Unicode Information

The ``Emoji`` type has unicode-specific properties that can be used for identity and naming:

```swift
Emoji("👍").unicodeIdentifier   // \\N{THUMBS UP SIGN}
Emoji("👍🏿").unicodeIdentifier   // \\N{THUMBS UP SIGN}\\N{EMOJI MODIFIER FITZPATRICK TYPE-6}
Emoji("🚀").unicodeIdentifier   // \\N{ROCKET}
Emoji("👍").unicodeName         // Thumbs Up Sign
Emoji("👍🏿").unicodeName         // Thumbs Up Sign
Emoji("🚀").unicodeName         // Rocket
```

> Note: There are currently some gaps where certain emojis have the same identifier. This should be fixed.


## Localization

The ``Emoji`` type can be localized in any locale that has defined translations:

```swift
let swedish = Locale(identifier: "sv")

Emoji("😀").localizedName                // Grinning Face
Emoji("😀").localizedName(in: .swedish)  // Leende Ansikte
```

EmojiKit is currently localized in:

* English
* Swedish

Anyone can contribute to provide support for more locales. See the `Resources` folder for information on how to localize emojis.


## Skin tones

Some ``Emoji`` values have skin tone variants:

```swift
Emoji("👍").hasSkinToneVariants     // true
Emoji("🚀").hasSkinToneVariants     // false
Emoji("👍🏿").neutralSkinToneVariant  // 👍
Emoji("👍").skinToneVariants        // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
```

> Note: Skin tone support for emojis with multiple skin tone components are currently not supported, such as two persons kissing.


## Transferable

The ``Emoji`` type conforms to the `Transferable` protocol, which means that it can use native features like drag & drop, sharing, etc.

Make sure to specify that your app supports the ``UniformTypeIdentifiers/UTType/emoji`` uniform type, to use these features.  



## Automatic Category Updates

The ``Emoji`` type has a ``Emoji/registerUserSelection()`` function that can be called whenever a user selects an emoji. This will update the ``EmojiCategory/recent`` and ``EmojiCategory/frequent`` categories accordingly.

This function is automatically called by ``EmojiGrid``, so you don't need to call the function manually when you use the grid component.

> Important: EmojiKit currently doesn't have an algoritm for frequency calculations, so this function will apply the same changes to both the recent and the frequent category. You can however use the ``EmojiCategory/frequent`` category to implement your own frequency logic.
