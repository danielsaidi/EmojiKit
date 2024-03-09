# Release Notes

EmojiKit will use semver after 1.0. 

Until then, minor updates may remove deprecated features and introduce breaking changes.



## 0.3

This version makes the EmojiKit foundation open-source.

As such, there are a few breaking changes in this version.

The biggest changes is that there are no longer any throwing SDK features, which will make it a lot easier to use.

This version also moves types out from the `Emoji` type, since the SDK is smaller and don't need any surface area optimizations.

This version also removes UI components and assets. These will be available as Pro add-ons in a future update.



## 0.2

This update tweaks a few things in EmojiKit.

### ✨ New Features

* `Emoji.GridConfiguration` can now be created with just a font size.
* `LazyHGrid` and `LazyVGrid` has new EmojiKit-based initializers.

### 💡 Adjustments

* `Image` extensions replace individual assets with a category-based function.

### 🐛 Bug Fixes

* This update fixes a problem that made the SDK not include macOS support
* This update fixes a bundle problem when resolving images and localized strings.



## 0.1

This is the very first beta release of EmojiKit.

### ✨ New Features

* `Emoji` is a struct with Emoji-specific properties and features, and also serves as a namespace for the library.
* `Emoji` supports unicode information, localization, search, categories, skin tones, and emoji version information.
* `Emoji` also has `Grid` and `Picker` UI components.  
