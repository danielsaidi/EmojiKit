# Views

This article describes the EmojiKit view and styling support.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

## EmojiGrid & EmojiScrollView

EmojiKit has an ``EmojiGrid`` that can be used to list and pick emojis in a horizontal or vertical grid, as well as an ``EmojiScrollGrid`` that wraps an ``EmojiGrid`` and automatically scrolls to the current selection. 

@Row {
    @Column {
        ![EmojiGrid](emojigrid.jpg)

        A plain ``EmojiGrid``.
    }
    @Column {
        ![EmojiGrid with selection](emojigrid-selection.jpg)
        
        An ``EmojiGrid`` with a selected state.
    }
    @Column {
        ![EmojiGrid with large style](emojigrid-large.jpg)
        
        An ``EmojiGrid`` with ``EmojiGridStyle/extraLarge`` style.
    }
}

The grid can list ``Emoji`` or ``EmojiCategory`` collections. If multiple categories are listed, a section title is added before each category.

The view can be styled with a ``EmojiGridStyle``, which can be applied with the ``SwiftUI/View/emojiGridStyle(_:)`` view modifier. There are many predefined styles, such as ``EmojiGridStyle/standard``, ``EmojiGridStyle/small``, ``EmojiGridStyle/large``, etc. 

You can customize each view in the grid, by returning a custom view in the item builder. To use the standard view, just return `$0.view`.

The grid will by default use a ``MostRecentEmojiProvider`` provider to get emojis for the ``EmojiCategory/frequent`` category. You can replace this provider with a custom one if you want.

The grid automatically calls ``FrequentEmojiProvider/registerEmoji(_:)`` whenever its selection changes, to automatically update the ``EmojiCategory/frequent`` category.
