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

The ``EmojiGrid`` can display a list of ``Emoji`` or ``EmojiCategory`` values. If multiple categories are provided, the grid inserts a section title before each category section, but only if the axis is vertical.


### How to customize section titles and grid items

The ``EmojiGrid`` has section title and grid item view builders that can be used to customize the section title and grid item views. Return `$0.view` to use the standard views, or return any custom views for the provided parameters.


### How to style the grid

The ``EmojiGrid`` can be styled with a ``SwiftUICore/View/emojiGridStyle(_:)`` modifier, which can customize grid item sizes, grid padding, etc. This modifier can be applied to any part of the view hierarchy.


### How to change the grid selection

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

If you use a custom `ScrollView`, you must use the emoji's ``Emoji/id(in:)`` property to scroll to a certain emoji when the grid has multiple emoji categories, since the unique emoji IDs will then be adjusted for each category.


### How to filter the grid content

You can pass in a `query` string to filter the emojis in the grid. Passing in a non-empty query will make it list a single ``EmojiCategory/search(query:)`` category. You can combine this with the `.searchable(...)` view modifier to let users modify the query.


### How to update the recent and frequent emoji categories

The ``EmojiGrid``will automatically call the emoji's ``Emoji/registerUserSelection()`` function when an emoji is picked in the grid. This will automatically update all affected categories, so you don't need to call the function manually when you use the grid component.

> Important: Since EmojiKit currently doesn't have an algoritm for frequency calculations, the ``EmojiCategory/frequent`` will currently be updated just like the ``EmojiCategory/recent`` category. You can however use the ``EmojiCategory/frequent`` category to implement your own frequency logic.
