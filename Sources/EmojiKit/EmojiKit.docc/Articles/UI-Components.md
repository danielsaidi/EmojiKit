# UI Components

This article describes the UI components that EmojiKit provides.

The <doc:Getting-Started> article has information on how to add EmojiKit to your project and register your license key. This is required before using many of the features that are listed below.



## Image Assets

EmojiKit has `Image` extensions for the various ``EmojiCategory`` icons:

![Emoji Category Icons](emoji-category-icons.png)

You can either get the icon from a category value, or by using the image extension directly:

```swift
Emoji.Category.smileys.icon
Image.emojiCategory(.smileys)
Image.emojiCategorySearch
```

The image assets are vectorized, so you can scale them as needed.



## Emoji Grid

EmojiKit has an ``Emoji/Grid`` that lets you list emojis in a horizontal or vertical grid.

![Emoji Grid](emoji-grid-vertical.png)

The following code renders a vertically scrolling grid with a standard configuration and standard grid items:

```swift
struct ContentView: View {

    var body: some View {
        ScrollView(.vertical) {
            try? Emoji.Grid { 
                $0.view 
            }
        }
    }
}
```

The following code does the same, but types out all available parameters:

```swift
try? Emoji.Grid(
    categories: .all,
    selection: .constant(nil),
    axis: .vertical,
    config: .standard,
    section: { $0.view },
    content: { $0.view }
)
```

You can provide a custom configuration to change item size, font size, spacing, etc.:

```swift
try? Emoji.Grid(
    categories: .all,
    selection: .constant(nil),
    axis: axis,
    config: .large,
    section: { $0.view },
    content: { $0.view }
)
```

You can also customize any item in the grid:

```swift
try? Emoji.Grid { params in
    let isCrazy = params.emoji.char == "🤪"
    params.view
        .rotationEffect(.degrees(isCrazy ? 180 : 0))
        .scaleEffect(isCrazy ? 1.5 : 1)
}
```

Since the font and item sizes are defined separately, make sure that your custom configuration looks good on all device types.



## Emoji Grid Picker

EmojiKit has an ``Emoji/GridPicker`` that lets you pick emojis in a horizontally or vertically scrolling grid.

![Emoji Picker](emoji-picker-vertical.png)

The picker is created just like the ``Emoji/Grid``, but wraps itself in a `GeometryReader`, `ScrollViewReader` and `ScrollView` and applies focus and keyboard modifiers that make it possible to pick emojis with a mouse, a keyboard, or by tapping with your finger.

The picker also automatically show all available emoji skintones when long pressing:

![Emoji Picker Callouts](emoji-picker-popover.png)

> Important: Note that the focus and keyboard shortcuts only with in iOS 17 and macOS 14, and that the popovers only work on iOS 16.4 and macOS 12.



## Emoji Skintone Popover

EmojiKit has an ``Emoji/SkintonePopover`` that lets you show all available skintones in a handy popover.

![Emoji Skintone Popover](emoji-skintone-popover.png)

The popover can be applied to any view:

```swift
struct ContentView: View {
    
    let emoji = Emoji("👍")
    
    @State
    var isPopoverPresented = false
    
    var body: some View {
        Button {
            isPopoverPresented.toggle()
        } label: {
            Text(emoji.char)
        }
        .popoverIfAvailable($isPopoverPresented) {
            Emoji.SkintonePopover(
                emoji: emoji,
                action: { _ in isPopoverPresented.toggle() }
            )
        }
    }
}
```

> Important: Note that this popover only work on iOS 16.4 and macOS 12.


[GitHub]: https://github.com/Kankoda/EmojiKit
[Website]: https://kankoda.com/emojikit
