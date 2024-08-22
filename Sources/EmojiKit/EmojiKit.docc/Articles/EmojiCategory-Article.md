# Emoji Category

This article describes the EmojiKit emoji category model.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

EmojiKit has an ``EmojiCategory`` enum that defines all available emoji categories and their included emojis:

```swift
try EmojiCategory.smileysAndPeople.emojis  // 😀😃😄...
try EmojiCategory.animalsAndNature.emojis  // 🐶🐱🐭...
```

You can use ``EmojiCategory/standard`` to get a list of all standard categories, in the native sort order:

```swift
EmojiCategory.standard  // [.frequent, .smileyAndPeople, ...]
```

``EmojiCategory`` uses the ``EmojiVersion`` enum to filter out emojis that are unavailable to the current runtime. This means that your users will only see emojis they can use.


## Frequent Emojis

The ``EmojiCategory/frequent`` category is only a placeholder category that doesn't contain any emojis from start. You can instead use  it to render a title and icon, then use a ``EmojiProviders/MostRecentProvider`` to get a list of emojis to display.

Views like ``EmojiGrid`` and ``EmojiScrollGrid`` will automatically listen for selection changes, and register the new selection if you have passed in a frequent emoji provider into the view initializer.
 

## Favorite Emojis

The ``EmojiCategory/favorites`` category is a non-standard category that doesn't contain any emojis from start. You can instead use it to render a title and icon, then use a ``EmojiProviders/FavoriteProvider`` to get a list of emojis to display.
 

## How to use an emoji provider

You can use an emoji provider's  ``EmojiProvider/addEmoji(_:)`` function to add news emojis whenever the user interacts with an emoji, if the provider ``EmojiProvider/canAddEmojis``.

Both ``EmojiProviders/MostRecentProvider`` and ``EmojiProviders/FavoriteProvider`` can be used to add custom emojis. They use different underlying data stores to avoid conflicts.
