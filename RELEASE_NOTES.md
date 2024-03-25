# Release Notes

EmojiKit will use semver after 1.0. 

Until then, minor updates may remove deprecated features and introduce breaking changes.



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
