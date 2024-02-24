# Release Notes

EmojiKit will use semver after 1.0. 

Until then, minor updates may remove deprecated features and introduce breaking changes.



## 0.3

This version makes the EmojiKit foundation open-source.

As such, there are many breaking changes in this version, too many to list here.

The biggest changes is this release is moving out some types from within the `EmojiType`, since the library is now smaller and no longer needs these API surface area optimizations.

EmojiKit also no longer contains UI components or assets. These will be available as a Pro add-on, and will include grids, pickers and vectorized assets.



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
