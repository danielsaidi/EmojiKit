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

EmojiKit has an ``EmojiGrid`` that can be used to list and pick emojis in a horizontal or vertical grid. It can list emojis and categories, and also supports keyboard commands to let you easily move and apply the current selection.

@Row {
    @Column {
        ![EmojiGrid with selection](emojigrid-selection.jpg)
        
        An ``EmojiGrid`` with a selected state.
    }
    @Column {
        ![EmojiGrid with large style](emojigrid-large.jpg)
        
        An ``EmojiGrid`` with ``EmojiGridStyle/extraLarge`` style.
    }
}

You can also use an ``EmojiScrollGrid`` to wrap an ``EmojiGrid`` in a scroll view that automatically scrolls to the current selection.


### How to list emojis and categories

The ``EmojiGrid`` can display a list of ``Emoji`` or ``EmojiCategory`` values. If multiple categories are provided, they will insert a section title before each category section.


### How to customize and style the grid

The `section` and `content` view builders can be used to define the section and grid content views. Simply return `$0.view` to apply the standard views, or return any custom views for the provided parameters.

You can use the ``SwiftUICore/View/emojiGridStyle(_:)`` view modifier to apply a custom emoji grid style, which can be used to customize item sizes, grid padding, etc. This view modifier can be applied to any part of the view hierarchy.


### How to change the selection

The `selection` parameter can be used to bind the ``EmojiGrid`` to an external selection. You can tap/click on any emoji to select it and trigger the provided `action`, and use the arrow/move keys to move the selection without triggering the grid `action`.


### How to use the grid with a keyboard

The ``EmojiGrid`` supports the following keyboard commands:

Key                  | Description                          
-------------------- | ------------------------------------- 
`arrow keys`         | Move the current selection.  
`enter/return`       | Pick/trigger the current emoji.           
`enter/return`+`opt` | Show a skin tone popover, where applicable.            
`escape`             | Reset the current selection.            
`space`              | Select an emoji within a skin tone popover.            
`tab`                | Move selection within a skin tone popover.


### How to scroll to a certain emoji

The ``EmojiScrollGrid`` will automatically scroll to the current `selection`, so you just have to update the binding value that you provide to the grid to make it scroll to that emoji.

If you use a custom `ScrollView`, you must use the ``Emoji/id(in:)`` property to properly scroll to a certain emoji when the grid displays multiple emoji categories.


### How to filter the grid content

You can pass in a `query` string to filter the emojis in the grid. Passing in a non-empty query will make it list a single ``EmojiCategory/search(query:)`` category. You can combine this with the `.searchable(...)` view modifier and use the same query in both places.


### How to list and update the frequent emoji category

You can pass in a ``EmojiCategory/PersistedCategory`` into the ``EmojiGrid``, to automatically let it add emojis to the provided category when a user taps or picks emojis in the grid.
