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

EmojiKit has an ``EmojiGrid`` that can be used to list and pick emojis in a horizontal or vertical grid, as well as an ``EmojiScrollGrid`` that wraps an ``EmojiGrid`` in a `ScrollView` and automatically scrolls to the current selection whenever it changes. 

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


### How to list emojis and categories

These grids can display a list of ``EmojiCategory`` values, or a list of ``Emoji`` values. If multiple categories are provided, they will insert a section title view before each category section.

You can pass in a `query` string to filter the emojis in the grid. Passing in a non-empty query will make it list a single ``EmojiCategory/search(query:)`` emoji category. You can combine this with the `.searchable(...)` view modifier and use the same query in both places.


### How to use custom the grid content

The `section` and `content` view builders can be used to define the section and grid content views. Simply return `$0.view` to apply the standard views, or return any custom views for the provided parameters.

You can use the ``SwiftUI/View/emojiGridStyle(_:)`` view modifier to apply a custom emoji grid style, which can be used to customize item sizes, grid padding, etc. This view modifier can be applied to any part of the view hierarchy.


### How to change the selection

The `selection` parameter can be used to bind these grids to an external selection. You can tap/click on any emojis to select it and trigger the emoji `action`, and use the arrow/move keys to move the `selection`, without triggering the `action`.

Here's a list of all keys and key combinations that are supported by the grid:

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



### How to list and update the frequent emoji category

If you pass in a `frequentEmojiProvider`, this grid will use it to populate the ``EmojiCategory/frequent`` category, and automatically register all emojis that the user taps or picks with the return key.
