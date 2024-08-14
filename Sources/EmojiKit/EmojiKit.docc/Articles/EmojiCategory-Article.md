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

You can use ``EmojiCategory/all`` to get a list of all available categories, in the native, default sort order:

```swift
EmojiCategory.all      // [.frequent, .smileyAndPeople, ...]
```

``EmojiCategory`` uses the ``EmojiVersion`` enum to filter out emojis that are unavailable to the current runtime. This means that your users will only see emojis they can use.


## Frequent Emojis

Note that the ``EmojiCategory/frequent`` category is only a placeholder category that doesn't define any emojis. Instead, use the category to render a correct title and icon for the category, then use an ``EmojiProvider`` to get a list of emojis to display.

You can use an emoji provider's  ``EmojiProvider/addEmoji(_:)`` function to add news emojis whenever the user interacts with an emoji, if the provider ``EmojiProvider/canAddEmojis``. 

The ``EmojiProviders/MostRecentProvider`` will just display the most recently used emojis, without any sophisticated frequent algorithm.

Views like ``EmojiGrid`` and ``EmojiScrollGrid`` will automatically listen for selection changes, and register the new selection if you have passed in a frequent emoji provider into the view initializer.
 
