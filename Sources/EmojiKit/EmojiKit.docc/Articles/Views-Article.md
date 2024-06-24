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

These grids can display a list of ``EmojiCategory`` values, or a list of ``Emoji`` items. If multiple categories are provided, they add a section title to each category.

The `section` and `content` view builders can be used to customize the section titles and grid items. Just return `0.view` to use the standard views.

You can pass in a `query` to filter which emojis to list. You can tap/click on any emojis to select it and trigger the provided emoji `action`. You can use arrow/move keys to move the `selection`, without triggering the `action`.

You can use the ``emojiGridStyle(_:)`` modifier to apply a custom grid style, to customize item size, padding etc.

You can tap/click on any emojis to select it and trigger the provided emoji `action`. You can use arrow/move keys to move the `selection`, without triggering the `action`.

Here's a list of all supported keys and key combinations:

- `arrows`: Move the current selection.
- `enter/return`: Pick/trigger the current emoji.
- `enter/return`+`opt`: Show a skin tone popover.
- `escape`: Reset the current selection.
- `space`: Select an emoji within a skin tone popover.
- `tab`: Move selection within a skin tone popover.

The skin tone popover currently requires that you change selection with tab and selects an emoji with space. This popover should have the same key bindings as the grid.

If you pass in a `frequentEmojiProvider`, this grid will use it to populate a ``EmojiCategory/frequent`` category, and automatically register all picked emojis.
