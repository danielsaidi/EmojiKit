# Release Notes

EmojiKit will use semver after 1.0. 

Until then, minor updates may remove deprecated features and introduce breaking changes.



## 0.5

This version adds support for strict concurrency.

The strict concurrency change required the library to remove the shared `FrequentEmojiProvider`.

A side-effect of this is that the `.frequent` emoji category no longer defines any emojis, and is now only used as a placeholder to defines the id, title, icon, etc. for that category.

While this may seem more complicated, it *is* actually better, since it lets us use different providers instead of relying on a single instance. It's also more obvious when using the SDK.

The various views, like `EmojiGrid` and the new `EmojiScrollGrid`, will also automatically use a `MostRecentEmojiProvider` which lets you completely ignore this architectural change in most cases.

This version also adds a demo app to the repository, to make it easier to play around with it.  

### ✨ New Features

* `Emoji` now conforms to `Hashable`.
* `Emoji.GridSelection` now conforms to `Hashable`.
* `EmojiCategory` is refactored to have a concurrent-safe cache.
* `EmojiScrollGrid` is a new grid that auto-scrolls to the selection.
* `MostRecentEmojiProvider` now lets you use a custom persistency key.
* `ScrollViewProxy` can now scroll to a specific `Emoji.GridSelection`.

### 💡 Changes

* `EmojiCategory.frequent` no longer returns any emojis.
* `EmojiGrid` now lets you inject a custom frequent emoji provider.



## 0.4

This version adds a new EmojiGrid component.

### ✨ New Features

* `EmojiGrid` is a new grid component.
* `EmojiGridStyle` is a new, environment-based style.
* `Emoji` has more nested components that are used by the grid. 



## 0.3

This version makes the EmojiKit foundation open-source.

The biggest changes in this version, is that there are no longer any throwing SDK features. This version also moves types out from the `Emoji` type, since the SDK is smaller than before.

This version also removes UI components and assets. These will be available in future updates.



## 0.2

This update tweaks a few things in EmojiKit.

### 🐛 Bug Fixes

* This update fixes a problem that made the SDK not include macOS support
* This update fixes a bundle problem when resolving images and localized strings.



## 0.1

This is the very first beta release of EmojiKit.

### ✨ New Features

* `Emoji` is a struct with Emoji-specific properties and features, and also serves as a namespace for the library.
* `Emoji` supports unicode information, localization, search, categories, skin tones, and emoji version information.
* `Emoji` also has `Grid` and `Picker` UI components.  
