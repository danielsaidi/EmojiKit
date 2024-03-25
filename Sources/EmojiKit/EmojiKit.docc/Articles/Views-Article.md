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

## EmojiGrid

EmojiKit has an ``EmojiGrid`` that can be used to list and pick emojis in a horizontal or vertical grid.

@Row {
    @Column {
        ![EmojiGrid](emojigrid.jpg)
        
        A plain ``EmojiGrid``.
    }
    @Column {
        ![EmojiGrid with selection](emojigrid-selection.jpg)
        
        An ``EmojiGrid`` with selected state.
    }
    @Column {
        ![EmojiGrid with large style](emojigrid-large.jpg)
        
        An ``EmojiGridStyle/extraLarge`` ``EmojiGrid``.
    }
}

The grid can list ``Emoji`` or ``EmojiCategory`` collections. If multiple categories are provided, the view adds a title before each category.

The view can be styled with a ``EmojiGridStyle``, which can be applied with the ``SwiftUI/View/emojiGridStyle(_:)`` view modifier.
