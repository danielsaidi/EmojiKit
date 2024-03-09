# UI Components

This article describes the UI components that EmojiKit Pro provides.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

EmojiKit Pro will be a future add-on to EmojiKit. It will provide additional UI components that make it easier to build emoji-based apps.


## 👑 EmojiKit Pro

EmojiKit Pro provides image extensions and UI components.

@TabNavigator {
    
    @Tab("Image Assets") {
        EmojiKit Pro has `Image` extensions for the various ``EmojiCategory`` values:

        ```swift
        Emoji.Category.smileys.icon
        Image.emojiCategory(.smileys)
        Image.emojiCategorySearch
        ```

        These image assets aim to map as closely as possible to the native icons, and can be used as toolbar buttons and tab view item icons. 


        ![Emoji Category Icons](emoji-category-icons.png)

        The category image assets are vectorized, and can be scaled as needed.
    }
    
    @Tab("EmojiGrid") {
        
        @Row {
            @Column {
                EmojiKit has an `EmojiGrid` that lists emojis in a horizontal or vertical grid.
            }
            @Column(size: 2) {
                ![Emoji Grid](emoji-grid-vertical.png)
            }
        }
            
        @Row {
            @Column {
                This code renders a vertically scrolling grid with a standard configuration.
            }
            @Column(size: 2) {
                ```swift
                struct ContentView: View {

                    var body: some View {
                        ScrollView(.vertical) {
                            try? EmojiGrid { 
                                $0.view 
                            }
                        }
                    }
                }
                ```
            }
        }
            
        @Row {
            @Column {
                This grid can be customized a great deal:
            }
            @Column(size: 2) {
                ```swift
                try? EmojiGrid(
                    categories: .all,
                    selection: .constant(nil),
                    axis: .vertical,
                    config: .standard,
                    section: { $0.view },
                    content: { $0.view }
                )
                ```
            }
        }
            
        @Row {
            @Column {
                You can provide a custom configuration to change item size, font size, spacing, etc.:
            }
            @Column(size: 2) {
                ```swift
                try? EmojiGrid(
                    categories: .all,
                    selection: .constant(nil),
                    axis: axis,
                    config: .large,       // <-- Here
                    section: { $0.view },
                    content: { $0.view }
                )
                ```
            }
        }
            
        @Row {
            @Column {
                You can customize any item in the grid, using the provided `params` information as you see fit. 
            }
            @Column(size: 2) {
                ```swift
                try? EmojiGrid { params in
                    let isCrazy = params.emoji.char == "🤪"
                    params.view
                        .rotationEffect(.degrees(isCrazy ? 180 : 0))
                        .scaleEffect(isCrazy ? 1.5 : 1)
                }
                ```
            }
        }
        
        > Important: Since the font and item sizes are defined separately, make sure that your custom configuration looks good on all device types.
    }
    
    @Tab("EmojiGridPicker") {
        @Row {
            @Column {
                EmojiKit has an `EmojiGridPicker` that lets you pick emojis in a horizontally or vertically scrolling grid, with rich focus and keyboard support.
            }
            @Column(size: 2) {
                ![Emoji Picker](emoji-picker-vertical.png)
            }
        }
        @Row {
            @Column {
                A picker is created like an `EmojiGrid`, but wraps itself in a `ScrollView` and applies focus and keyboard modifiers that make it possible to navigate the grid and pick emojis with a mouse, a keyboard, or by tapping with your finger.
            }
            @Column(size: 2) {
                ![Emoji Picker](emoji-picker-vertical.png)
            }
        }
        @Row {
            @Column {
                The picker automatically show all available emoji skintones when long pressing any item in the grid, that has skintone variants:
            }
            @Column(size: 2) {
                ![Emoji Picker Callouts](emoji-picker-popover.png)
            }
        }
            
        > Important: Note that the focus support and keyboard shortcuts only with in iOS 17 and macOS 14, and that the popovers only work in iOS 16.4 and macOS 12.
    }
}
