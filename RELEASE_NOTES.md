# Release Notes

LicenseKit honors semantic versioning to great extent:

* Only remove deprecated code in `major` versions.
* Only deprecate code in `minor` and `patch` versions.
* Avoid breaking changes in `minor` and `patch` versions.
* Code can be marked as deprecated at any time.

Breaking changes *can* still occur in minor versions and patches, if the alternative is to not be able to release important new features or fixes.



## 0.3

This version improves the grid and grid picker's focus and keyboard support. Due to the required changes to get this to work, the APIs have many breaking changes.

This version also localizes emoji categories.

### ✨ New Features

* `Emoji.Category` is now properly localized.
* `Emoji.Category` has a new `custom` category type.
* `Emoji.Grid` can now also use a selection binding.
* `Emoji.Grid` now provides an index to the view builder.
* `Emoji.Grid` now automatically highlights its selection.
* `Emoji.GridItem` is a new view for standard emoji grid items.
* `Emoji.GridSelection` is a new struct for managing grid selection.

### 💡 Adjustments

* `Emoji.Grid` uses a view param struct instead of a tuple.
* `Emoji.GridPicker` uses the same view builders as the grid.

### 🗑️ Deprecations

* `Emoji.Picker` has been renamed to `GridPicker`.
* `LazyHGrid` and `LazyVGrid` extensions have been removed. 

### 💥 Breaking Changes

* `Emoji.Grid` and `Emoji.GridPicker` has many breaking changes.



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
