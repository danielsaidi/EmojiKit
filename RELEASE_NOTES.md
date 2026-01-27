# Release notes

[EmojiKit](https://github.com/danielsaidi/EmojiKit) tries to honor semantic versioning:

* Deprecations can happen in any version.
* Deprecations are only removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` & `patch` updates, if needed.



## 2.3

This version improves grid selection and adds some styling options.

### ✨ Features

* `EmojiCategory` has a new `.standardGridCategories` value.
* `EmojiGrid` and `EmojiGridScrollView` has a new `visibleCategoryId` binding.
* `Emoji.SkintonePopover` has a new `.emojiSkintonePopoverStyle` view modifier.
* `Emoji.SkintonePopoverStyle` can be used to set the visual style of a popover.

### 💡 Changes

* `EmojiGrid` and `EmojiGridScrollView` has renamed some init parameters.
* `EmojiGrid` and `EmojiGridScrollView` now uses an optional `selection` value.
* `EmojiGrid` and `EmojiGridScrollView` now persists to `.frequent` and `.recent` by default.



## 2.2.1

### 🐛 Bug Fixes

Thanks to [@josselin-oudry](https://github.com/josselin-oudry) the emoji grid skintone popover now works on iOS 16.



## 2.2

### 💡 Adjustments

* The package now uses Swift 6.1. 
* The demo app now targets iOS 26.



## 2.1

This version adds a `frequent` emoji category.

### ✨ Features

* `EmojiCategory` has new `.favorites`, `.frequent` and `.recent` builders.

### 💡 Adjustments

* `EmojiGrid` and `EmojiScrollGrid` only have a single initializer.
* `EmojiGrid` has a new `registerSelectionFor` init argument.
* `EmojiGridScrollView` no longer takes a geometry proxy parameter.

### 🗑️ Deprecations

* `Emoji.registerUserSelection` has been deprecated.



## 2.0

This version bumps deployment targets and removes deprecated code.

### 💥 Breaking Changes

* EmojiKit now targets iOS 16 and aligned platform versions.
* All previously deprecated code has been removed.
